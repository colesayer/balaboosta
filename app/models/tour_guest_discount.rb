class TourGuestDiscount < ApplicationRecord
  belongs_to :tour_guests, optional: true
  belongs_to :discounts, optional: true
end
