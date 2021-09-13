class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :artist
      t.integer :adam_id
      t.string :preview_url

      t.timestamps
    end
  end
end
