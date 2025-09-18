# frozen_string_literal: true

require Rails.root.join("app/types/point_type")

ActiveRecord::Type.register(:point, PointType)
