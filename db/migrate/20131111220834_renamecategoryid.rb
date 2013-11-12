class Renamecategoryid < ActiveRecord::Migration
  def change
    rename_column :polls, :category, :category_id
  end
end
