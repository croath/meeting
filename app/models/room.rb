class Room < ActiveRecord::Base
  has_many :orders, :inverse_of => :room
end
