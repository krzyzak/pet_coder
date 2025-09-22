class AddCompletedToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :completed, :boolean, default: false, null: false
    add_index :games, :completed
  end
end
