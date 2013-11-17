class Comment < ActiveRecord::Base
  has_one :poll
  
  validates_presence_of :rating
  validates_presence_of :comment
end
