# frozen_string_literal: true

class TreatObject < GameObject
  delegate :model_name, to: :Treat
end
