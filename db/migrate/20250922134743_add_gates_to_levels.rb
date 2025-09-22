class AddGatesToLevels < ActiveRecord::Migration[8.1]
  def change
    add_column :levels, :gates, :json, null: false, default: []
  end
end
