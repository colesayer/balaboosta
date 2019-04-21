class CalculateTourNet
  attr_reader :tour

  def initialize(tour)
    @tour = tour
    @reservations = tour.tour_guests
  end

  def total_amount_owed
    total = 0
    @reservations.each do |res|
      total += res.amount_owed
    end
    return total
  end


end
