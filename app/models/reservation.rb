class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :check_out_date, comparison: { greater_than: :check_in_date }, exclusion: { in: :unavailable_dates }

  validates :check_in_date, presence: true, exclusion: { in: :unavailable_dates }

  def unavailable_dates
    room.unavailable_dates
  end
end
