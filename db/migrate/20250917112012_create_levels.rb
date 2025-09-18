class CreateLevels < ActiveRecord::Migration[8.1]
  def change
    create_table :levels do |t|
      t.json :pet, null: false
      t.json :target, null: false
      t.json :walls, null: false,  default: []
      t.json :treats, null: false, default: []

      t.timestamps
    end
  end
end
