class Reservation < ApplicationRecord
  belongs_to :location
  belongs_to :user
  belongs_to :movie
end
