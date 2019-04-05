class RenameLiveColInAlbumsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :albums, :live, :is_live
  end
end
