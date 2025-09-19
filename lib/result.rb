# frozen_string_literal: true

class Result
  Error = Struct.new(:code, :message, keyword_init: true)

  def self.success(data = nil)
    new(success: true, data:, error: nil)
  end

  def self.failure(code, message = nil)
    new(success: false, data: nil, error: Error.new(code:, message:))
  end

  private_class_method :new

  attr_reader :data, :error

  def initialize(success:, data:, error:)
    @success = success
    @data = data
    @error = error
  end

  def success?
    @success
  end

  def failure?
    !success?
  end

  def error_code
    error&.code
  end

  def error_message
    error&.message
  end
end
