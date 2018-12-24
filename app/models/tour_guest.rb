class TourGuest < ApplicationRecord
  belongs_to :guest
  belongs_to :tour
  belongs_to :user
  has_many :comments, as: :noteable
  has_many :tour_guest_discounts
  has_many :discounts, through: :tour_guest_discounts

end
