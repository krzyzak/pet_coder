class PointType < ActiveRecord::Type::Value
  def cast(value)
    Point.new(x: value["x"], y: value["y"])
  end

  def serialize(value)
    value.as_json
  end

  def deserialize(original_value)
    Point.new(x: original_value["x"], y: original_value["y"])
  end

  def changed_in_place?(original_value, value)
    deserialize(original_value) != value
  end
end
