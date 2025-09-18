class PointSerializer < ActiveJob::Serializers::ObjectSerializer
  def klass
    Point
  end

  def serialize(point)
    super(point.as_json)
  end

  def deserialize(point)
    Point.new(x: point["x"], y: point["y"])
  end
end
