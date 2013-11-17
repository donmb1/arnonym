class Poll < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  
  attr_accessor :key_user, :key_admin
  
  # in order of appearance
  validates_presence_of :poll_title
  validates_presence_of :description
  validates_presence_of :category_id
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => true 
  
  def self.authenticate(code, password)
    poll_auth = find_by_code(code)
    if poll_auth && poll_auth.key_user_hash == BCrypt::Engine.hash_secret(password, poll_auth.key_user_salt)
      poll_auth
    else
      nil
    end
  end
  
  def self.authenticate_admin(code_admin, password_admin)
    admin_auth = find_by_code(code_admin)
    if admin_auth && admin_auth.key_admin_hash == BCrypt::Engine.hash_secret(password_admin, admin_auth.key_admin_salt)
      admin_auth
    else
      nil
    end
  end


end


