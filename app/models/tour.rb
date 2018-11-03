class Tour < ApplicationRecord
  has_many :tour_guests
  has_many :guests, through: :tour_guests
  belongs_to :location
  has_many :tour_users
  has_many :users, through: :tour_users
  has_many :payments

  # scope :past, -> { where('date < ?', Date.today )}
  scope :past_needs_approval, -> { where('date < ? AND is_approved != ?', Date.today, true)}
  scope :past_approved, -> { where('date < ? AND is_approved = ?', Date.today, true)}
  scope :upcoming, -> { where('date > ?', Date.today )}

  # scope :recent, lambda { :conditions => ['updated_at > ? AND admin != ?', 5.minutes.ago, true] }

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

  def is_past?
    Date.parse(date) < Date.today
  end

  def calculate_payment
    calculations = []

    tour_guide = {}
    guide = CalculateTourguidePayments.new(self)
    tour_guide[:payment] = guide.calculate_payment
    tour_guide[:user_id] = guide.get_user_id[0]

    booker = {}
    booking = CalculateBookingPayments.new(self).calculate_payment
    booking.each do |book|
      calculations << book
    end
    calculations << tour_guide
    return calculations
  end

end
