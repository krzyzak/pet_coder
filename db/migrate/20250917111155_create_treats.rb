class CreateTreats < ActiveRecord::Migration[8.1]
  def change
    create_table :treats do |t|
      t.string :name, null: false
      t.string :image_name, null: false
      t.integer :points, null: false

      t.timestamps
    end

    add_index :treats, :image_name, unique: true
  end
end
