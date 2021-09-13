class UpdateColumnToUnique < ActiveRecord::Migration[6.0]
  def change
    add_index :tracks, :adam_id, :unique => true
    add_index :tracks, :preview_url, :unique => true
  end
end
