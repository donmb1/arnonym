class Renamecolumns < ActiveRecord::Migration
  def change
    rename_column :polls, :name, :poll_title
    rename_column :categories, :name, :category_title
  end
end
