class Tour < ApplicationRecord
  has_many :tour_guests
  has_many :guests, through: :tour_guests
  belongs_to :location


# for form collection_select
def formatted_name
  "#{self.location.name} - #{self.date}"
end

def num_enrolled
  enrolled = 0
  self.tour_guests.each do |tour|
    enrolled += tour.num_guests if tour.num_guests
  end
  enrolled
end

end
