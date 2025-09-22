# frozen_string_literal: true

class GateObject < GameObject
  def opened?
    @opened
  end

  def closed?
    !opened?
  end

  def open!
    @opened = true
  end

  def image_name
    "gate_#{state}"
  end

  private

  def state
    opened? ? :opened : :closed
  end
end
