class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reservations
  has_many :users, through: :reservations

  def unavailable_dates
    all_dates = []
    reservations.pluck(:check_in_date, :check_out_date).map do |dates|
      current_date = dates[0]
      while current_date <= dates[1]
        all_dates.push(current_date)
        current_date += 1.day
      end
    end
    all_dates
  end
end
