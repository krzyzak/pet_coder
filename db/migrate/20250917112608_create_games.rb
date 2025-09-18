class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.references :player, null: false, foreign_key: true
      t.integer :lives, null: false
      t.integer :points, null: false, default: 0
      t.references :pet, null: false, foreign_key: true
      t.references :treat, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: true
      t.references :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
