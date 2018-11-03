class CalculateBookingPayments
  attr_reader :tour

  def initialize(tour)
    @tour = tour
    @reservations = tour.tour_guests
  end

  def calculate_payment
    payments = []
    @reservations.each do |reservation|
      booking_payment = {}
      booking_payment[:user_id] = reservation.user.id
      booking_payment[:tour_id] = @tour.id
      if reservation.user.first_name == "Neta"
        booking_payment[:payment] = @tour.base_price * reservation.num_guests * 0.20
      elsif reservation.user.first_name == "Noa"
        booking_payment[:payment] = reservation.num_guests * 3
      else
        booking_payment[:payment] = 0
      end
      payments << booking_payment
    end
    return payments
  end

end
