class Discount < ApplicationRecord
  has_many :tour_guest_discounts
  has_many :tour_guests, through: :tour_guest_discounts
end
