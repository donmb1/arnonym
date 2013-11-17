class Addemailtopoll < ActiveRecord::Migration
  def change
    add_column :polls, :email, :string
  end
end
