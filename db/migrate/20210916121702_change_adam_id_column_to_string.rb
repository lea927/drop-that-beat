class ChangeAdamIdColumnToString < ActiveRecord::Migration[6.0]
  def change
    change_column :tracks, :adam_id, :string
  end
end
