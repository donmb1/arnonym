class Poll < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  
  attr_accessor :key_user, :key_admin
  
  def self.authenticate(code, password)
    poll_auth = find_by_code(code)
    if poll_auth && poll_auth.key_user_hash == BCrypt::Engine.hash_secret(password, poll_auth.key_user_salt)
      poll_auth
    else
      nil
    end
  end

end


