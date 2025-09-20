class AddGameRulesToPlayer < ActiveRecord::Migration[8.1]
  def change
    add_column :players, :read_game_rules, :boolean, null: false, default: false
  end
end
