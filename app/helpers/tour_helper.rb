module TourHelper

  def hasDiscount(reservation)
    if reservation&.tour_guest_discounts[0]&.discount_id
      reservation&.tour_guest_discounts[0]&.discount_id
    else
      0
    end
  end

  def calculateAmountOwed(tour, reservation, discount = nil, num_ppl = 0)
    if discount
      discount_amount = discount.percentage_amount * tour.base_price * num_ppl
      (tour.base_price * reservation.num_guests) - discount_amount
    else
      tour.base_price * reservation.num_guests
    end
  end

end
