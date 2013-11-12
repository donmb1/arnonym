class Comment < ActiveRecord::Base
  has_one :poll
end
