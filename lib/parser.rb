# frozen_string_literal: true

class Parser
  class Context
    attr_reader :commands

    def initialize
      @commands = []
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

  def initialize
    @context = Context.new
  end

  def parse(text)
    context.instance_eval(text)
    context.commands
  end

  delegate :commands, to: :context

  def clear!
    @context = Context.new
  end

  private

  attr_reader :context
end
