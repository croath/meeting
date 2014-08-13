class Room < ActiveRecord::Base
  has_many :orders, :inverse_of => :room

  def desc
    self.name << " - " << self.description
  end
end
