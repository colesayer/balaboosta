class CalculateTourguidePayments
  attr_reader :tour

  def initialize(tour)
    @tour = tour
    @tourguide = tour.users
    @reservations = tour.tour_guests
    @location = tour.location.name
  end

  def number_guests
    num_guests = 0
    @reservations.each do |res|
      num_guests += res.num_guests if !res.is_cancelled
    end
    return num_guests.to_i
  end

  def calculate_payment
    amount = 0
    if @tour.is_private
      amount += calculate_private_tour
    elsif @location == "Chelsea" || @location == "Soho"
      amount += calculate_chelsea_soho_payment
    else
      amount += calculate_les_payment
    end
    return amount
  end

  def get_user_id
    @tourguide.ids
  end

  private

  def calculate_private_tour
    case number_guests
    when 0
      0
    when 1..2
      130
    when 3..4
      150
    when 5..9
      (number_guests - 4) * 10 + 150
    when 10
      220
    else
      (number_guests - 10) * 20 + 220
    end
  end

  def calculate_chelsea_soho_payment
    case number_guests
    when 0
      0
    when 1..4
      130
    when 5..6
      140
    when 7..9
      (number_guests - 6) * 10 + 140
    when 10
      190
    when 11
      200
    else
      (number_guests - 11) * 20 + 200
    end
  end

  def calculate_les_payment
    case number_guests
    when 0
      0
    when 1..4
      140
    when 5
      150
    when 6
      165
    when 7
      170
    when 8
      180
    else
      (number_guests - 8) * 20 + 180
    end
  end

end
