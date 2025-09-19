class AddHolesToLevels < ActiveRecord::Migration[8.1]
  def change
    add_column :levels, :holes, :json, null: false, default: []
  end
end
