# frozen_string_literal: true

require "open3"

class Parser
  def parse(input)
    result = execute_in_sandbox(input)

    if result[:success]
      Result.success(commands: parse_commands_from_output(result[:stdout]))
    else
      Result.failure(:error)
    end
  end

  private

  def docker_cmd(timeout)
    [
      "docker",
      "run",
      "--rm",
      "-i",
      "--network=none",
      "--memory=32m",
      "--cpus=0.5",
      "--read-only",
      "--tmpfs=/tmp:size=10m",
      "--user=nobody:nobody",
      "--cap-drop=ALL",
      "--security-opt=no-new-privileges",
      "ruby:3.4-alpine",
      "timeout",
      "-k",
      "#{timeout}s",
      "#{timeout}s",
      "ruby",
    ].freeze
  end

  def execute_in_sandbox(input, timeout: 0.1)
    sandboxed_script = create_sandbox_script(input)

    begin
      stdout, stderr, status = Open3.capture3(*docker_cmd(timeout), stdin_data: sandboxed_script)

      {
        stdout: stdout,
        stderr: stderr,
        exit_code: status.exitstatus,
        success: status.success?,
        timeout: status.exitstatus == 124,
      }
    rescue => e
      {
        stdout: "",
        stderr: "Docker execution error: #{e.message}",
        exit_code: -1,
        success: false,
        timeout: false,
      }
    end
  end

  def create_sandbox_script(input)
    <<~RUBY
      require "json"
      class Context
        def initialize
          @commands = []
        end

        def commands
          @commands
        end

        def up
          @commands << :up
        end

        def down
          @commands << :down
        end

        def left
          @commands << :left
        end

        def right
          @commands << :right
        end
      end

      dangerous_constants = %w[
        IO File Dir Process Kernel
        Net HTTP HTTPS FTP SMTP
        Socket TCPSocket UDPSocket BasicSocket
        Open3 PTY Etc
        ObjectSpace GC
        Thread ThreadGroup Fiber
        Mutex ConditionVariable Queue SizedQueue
      ]

      dangerous_constants.each do |const|
        Object.send(:remove_const, const) if Object.const_defined?(const)
      rescue NameError
      end

      dangerous_kernel_methods = %w[
        system exec spawn fork
        ` open popen popen3
        require require_relative load
        autoload autoload?
        eval instance_eval class_eval module_eval
        send public_send __send__
        method_missing respond_to_missing?
        const_get const_set const_defined? const_missing
        remove_const private_constant
        exit exit! abort at_exit
        trap Signal
        caller caller_locations
        binding
        set_trace_func trace_var untrace_var
        global_variables local_variables
        catch throw
        sleep
      ]

      dangerous_kernel_methods.each do |method|
        Kernel.send(:undef_method, method) if Kernel.method_defined?(method)
        Kernel.send(:undef_method, method) if Kernel.private_method_defined?(method)
      rescue NameError
      end

      dangerous_kernel_methods.each do |method|
        if self.respond_to?(method, true)
          singleton_class.send(:undef_method, method) rescue nil
        end
      end

      dangerous_object_methods = %w[
        send public_send __send__
        method eval instance_eval
        define_method define_singleton_method
        remove_method undef_method alias_method
        const_get const_set const_defined?
        instance_variable_get instance_variable_set
        remove_instance_variable
      ]

      dangerous_object_methods.each do |method|
        Object.send(:undef_method, method) if Object.method_defined?(method)
        Object.send(:undef_method, method) if Object.private_method_defined?(method)
      rescue NameError
      end

      [Class, Module].each do |klass|
        %w[new const_get const_set const_defined? const_missing remove_const
           define_method alias_method remove_method undef_method
           include extend prepend].each do |method|
          klass.send(:undef_method, method) if klass.method_defined?(method)
          klass.send(:undef_method, method) if klass.private_method_defined?(method)
        rescue NameError
        end
      end

      global_vars_to_clear = %w[$0 $PROGRAM_NAME $* $ARGV $< $> $stderr $stdin $stdout
                                $! $@ $& $` $' $+ $1 $2 $3 $4 $5 $6 $7 $8 $9
                                $~ $= $/ $\\ $, $; $. $<]

      global_vars_to_clear.each do |var|
        global_variables.include?(var.to_sym) && eval("\#{var} = nil") rescue nil
      end

      Object.define_singleton_method(:const_missing) { |name| nil }

      begin
        context = Context.new
        context.instance_eval("#{input}")
        puts JSON.dump(context.commands)
      rescue => e
        puts "Error: \#{e.class}: \#{e.message}"
      end
    RUBY
  end

  def parse_commands_from_output(output)
    JSON.parse(output.strip).map(&:to_sym)
  end
end
