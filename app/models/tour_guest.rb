class TourGuest < ApplicationRecord
  belongs_to :guest
  belongs_to :tour
  belongs_to :user
end
