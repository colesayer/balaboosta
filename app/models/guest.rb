class Guest < ApplicationRecord
  has_many :tour_guests
  has_many :tours, through: :tour_guests
  accepts_nested_attributes_for :tour_guests

  validates :email, uniqueness: true
  validates :first_name, presence: true,  length: { minimum: 2 }
  validates :last_name, presence: true,  length: { minimum: 2 }

  before_destroy :destroy_tour_guests

  def formatted_name
    "#{self.first_name} #{self.last_name}"
  end

  def num_guests tour
    self.tour_guests.find_by(tour_id: tour.id).num_guests
  end

  def booked_by tour
    self.tour_guests.find_by(tour_id: tour.id).user.formatted_name
  end

  def self.search(search)
  if search
    name = search.split(' ')
    if name.length < 2
      where('first_name LIKE :search OR last_name LIKE :search', search: "%#{name[0]}%")
    else
      where("first_name LIKE ? AND last_name LIKE ?", "%#{name[0]}","%#{name[1]}")
    end
  else
    all
  end
end

  private

  def destroy_tour_guests
    self.tour_guests.destroy_all
  end
end
