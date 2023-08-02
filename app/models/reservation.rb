class Reservation < ApplicationRecord
  belongs_to :location
  belongs_to :user
  belongs_to :movie

  validates :start_date, presence: true
  validates :end_date, presence: true
end
