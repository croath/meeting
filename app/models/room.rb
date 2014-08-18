class Room < ActiveRecord::Base
  has_many :orders, :inverse_of => :room

  validates :name, presence: true
  validates :description, presence: true

  def desc
    self.name << " - " << self.description
  end
end
