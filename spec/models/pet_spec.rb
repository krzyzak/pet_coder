# frozen_string_literal: true

require "rails_helper"

RSpec.describe Pet do
  subject { build(:pet) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:image_name) }
  end
end
