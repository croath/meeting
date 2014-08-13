class Order < ActiveRecord::Base
  belongs_to :room, :inverse_of => :orders

  def progress
    now = DateTime.now.to_i
    all = self.end_time.to_i - self.start_time.to_i
    progress = 1.0 * (now - self.start_time.to_i) / all
    progress = (progress * 100).to_i.to_s
    progress
  end
end
