class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :username
      t.text :title
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
