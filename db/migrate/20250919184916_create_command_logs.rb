class CreateCommandLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :command_logs do |t|
      t.text :input
      t.references :game, null: false, foreign_key: true
      t.references :level, null: false, foreign_key: true
      t.boolean :success, null: false
      t.text :output
      t.timestamps
    end
  end
end
