class AddRoundsToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :rounds, :integer, default: 1
  end
end
