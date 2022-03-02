class AddCheckInDateToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :check_in_date, :datetime
  end
end
