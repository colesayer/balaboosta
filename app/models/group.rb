class Group < ApplicationRecord
  has_many :group_tours
  has_many :tours, through: :group_tours
  has_many :group_guests
  has_many :guests, through: :group_guests
  has_many :comments, as: :noteable

  def num_enrolled
    group_guests.length
  end
end
