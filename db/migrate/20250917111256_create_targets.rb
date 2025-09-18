class CreateTargets < ActiveRecord::Migration[8.1]
  def change
    create_table :targets do |t|
      t.string :name, null: false
      t.string :image_name, null: false

      t.timestamps
    end

    add_index :targets, :image_name, unique: true
  end
end
