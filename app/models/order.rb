require 'date'
class Order < ActiveRecord::Base
  belongs_to :room, :inverse_of => :orders

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :username, presence: true
  validates :room_id, presence: true
  validates :title, presence: true
  validate :same_day, :not_cross

  def same_day
    if !(Time.at(start_time).to_date === Time.at(end_time).to_date)
      errors.add(:start_time, '开始时间和结束时间只能在同一天')
    end
  end

  def not_cross
    day_orders = self.room.orders.map{|order| order if Time.at(order.start_time).to_date === Time.at(start_time).to_date}.compact
    for order in day_orders
      if (start_time <= order.start_time && end_time >= order.end_time) ||
        (start_time > order.start_time && start_time < order.end_time) ||
        (end_time > order.start_time && end_time < order.end_time)
        errors.add(:start_time, '与其他会议时间冲突')
        return
      end
    end
  end

  def progress
    now = DateTime.now.to_i
    all = self.end_time.to_i - self.start_time.to_i
    progress = 1.0 * (now - self.start_time.to_i) / all
    progress = (progress * 100).to_i.to_s
    progress
  end

  def easy_start_time
    self.start_time.to_s(format = :time)
  end

  def easy_end_time
    self.end_time.to_s(format = :time)
  end

  def create_date_time
    self.created_at.to_s(format = :short)
  end

  def meeting_date
    self.start_time.strftime("%m - %d")
  end
end
