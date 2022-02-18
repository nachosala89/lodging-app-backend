class AddCheckOutDateToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :check_out_date, :datetime
  end
end
