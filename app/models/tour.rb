class Tour < ApplicationRecord
  extend TimeSplitter::Accessors
  split_accessor :start_time

  has_many :tour_guests
  has_many :guests, through: :tour_guests
  belongs_to :location
  has_many :tour_users
  has_many :users, through: :tour_users
  has_many :group_tours
  has_many :groups, through: :group_tours
  has_many :payments
  has_many :comments, as: :noteable

  scope :past_needs_approval, -> { where('start_time < ? AND is_approved != ?', Date.today, true)}
  scope :past_approved, -> { where('start_time < ? AND is_approved = ?', Date.today, true)}
  scope :past, -> { where('start_time < ?', Date.today)}
  scope :upcoming, -> { where('start_time > ?', Date.today )}


  # for form collection_select
  def formatted_name
    "#{location.name} - #{formatted_date_short}"
  end

  def calendar_name
    "#{location.name} - #{formatted_time}"
  end

  def formatted_date_short
    if start_time
      return start_time.to_date.strftime('%b %d, %Y')
    end
  end

  def formatted_date_long
    if start_time
      return start_time.to_date.strftime('%A, %b %d, %Y')
    end
  end

  def formatted_time
    if start_time
      return start_time.to_time.strftime('%l:%M %p')
    end
  end

  def num_enrolled
    enrolled = 0
    self.tour_guests.each do |tour|
      enrolled += tour.num_guests if tour.num_guests && !tour.is_cancelled
    end
    enrolled
  end

  def num_cancelled
    cancelled = 0
    self.tour_guests.each do |tour|
      cancelled += tour.num_guests if tour.num_guests && tour.is_cancelled
    end
    cancelled
  end

  def is_past?
    start_time < Date.today
  end

  def calculate_net_amount
    net = CalculateTourNet.new(self)
    net.total_amount_owed
  end

  def calculate_payment
    calculations = []

    tour_guide = {}
    guide = CalculateTourguidePayments.new(self)
    tour_guide[:payment] = guide.calculate_payment
    tour_guide[:user_id] = guide.get_user_id[0]
    calculations << tour_guide

    booker = {}
    booking = CalculateBookingPayments.new(self).calculate_payment
    booking.each do |book|
      calculations << book
    end

    return calculations
  end

end
