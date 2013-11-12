class Changecolumns < ActiveRecord::Migration
  def change
    change_column :polls, :key_admin_hash, :string
    change_column :polls, :key_user_hash, :string
    change_column :polls, :key_admin_salt, :string
    change_column :polls, :key_user_salt, :string
  end
end
