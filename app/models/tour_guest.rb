class TourGuest < ApplicationRecord
  belongs_to :guest
  belongs_to :tour
  belongs_to :user
  has_many :comments, as: :noteable

end
