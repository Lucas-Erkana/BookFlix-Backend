class Location < ApplicationRecord
  has_many :reservations

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
end
