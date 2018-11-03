class Tour < ApplicationRecord
  has_many :tour_guests
  has_many :guests, through: :tour_guests
  belongs_to :location
  has_many :tour_users
  has_many :users, through: :tour_users


# for form collection_select
def formatted_name
  "#{location.name} - #{formatted_date_short}"
end

def formatted_date_short
  return date.to_date.strftime('%b %d, %Y')
end

def formatted_date_long
  return date.to_date.strftime('%A, %b %d, %Y')
end

def formatted_time
  return start_time.to_time.strftime('%l:%M %p')
end

def num_enrolled
  enrolled = 0
  self.tour_guests.each do |tour|
    enrolled += tour.num_guests if tour.num_guests
  end
  enrolled
end

end
