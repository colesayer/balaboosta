class PaymentsController < ApplicationController
  def index
    @tours = Tour.all.past_approved
  end

  def tour
    @tour = Tour.find_by(id: params[:tour_id])
    @payments = @tour.payments
  end
end
