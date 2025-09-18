Point = Struct.new(:x, :y, keyword_init: true) do
  def cast(values)
    self.class.new(x: values["x"], y: values["y"])
  end

  def serialize(original_value)
    original_value.as_json
  end

  def deserialize(original_value)
    self.class.new(x: original_value["x"], y: original_value["y"])
  end

  def changed_in_place?(original_value, value)
    deserialize(original_value) != value
  end

  def type
    :point
  end
end
