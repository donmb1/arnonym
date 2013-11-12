class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :name
      t.text :description
      t.integer :category
      t.string :code
      t.integer :key_admin_hash
      t.integer :key_admin_salt
      t.integer :key_user_hash
      t.integer :key_user_salt
      t.integer :pageviews

      t.timestamps
    end
  end
end
