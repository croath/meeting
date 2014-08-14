json.array!(@day_orders) do |order|
  json.username order.username
  json.start_time order.easy_start_time
  json.end_time order.easy_end_time
end
