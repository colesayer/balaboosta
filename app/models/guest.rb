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

  private

  def destroy_tour_guests
    self.tour_guests.destroy_all
  end
end
