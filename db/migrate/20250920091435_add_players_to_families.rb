class AddPlayersToFamilies < ActiveRecord::Migration[8.1]
  def change
    add_reference :players, :family, foreign_key: true
  end
end
