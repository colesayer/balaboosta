class ToursController < ApplicationController
  def index
    @upcoming_tours = Tour.upcoming
    @past_tours_needs_approval = Tour.past_needs_approval
    @past_tours_approved = Tour.past_approved
  end

  def show
    @tour = Tour.find(params[:id])
  end

  def add_guest
    @tour_guest = TourGuest.new(guest_id: params[:guest][:id], tour_id: params[:id], num_guests: params[:num_guests], user_id: params[:user_id][:id])
    if @tour_guest.save
      redirect_to tour_path(params[:id])
    else
      redirect_to tours_path
    end
  end

  def remove_guest
    guest = Guest.all.find(params[:guest_id])
    guest_tour = guest.tour_guests.find_by(tour_id: params[:id])
    guest_tour.destroy
    redirect_to tour_path(params[:id])
  end

  def new
    @users = User.role("TourGuide")
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.save
    redirect_to tour_path(@tour)
  end

  def edit
    @tour = Tour.find(params[:id])
  end

  def update
    @tour = Tour.find(params[:id])
    @tour.update(tour_params)
    redirect_to tour_path(@tour)
  end

  def edit_reservation
    @tour = Tour.find_by(id: params[:id])
    @guest = Guest.find_by(id: params[:guest_id])
    @tour_guest = @guest.tour_guests.find_by(tour_id: @tour.id)
  end

  def update_reservation
    @tour = Tour.find_by(id: params[:id])
    @guest = Guest.find_by(id: params[:guest_id])
    @tour_guest = @guest.tour_guests.find_by(tour_id: @tour.id)
    if @tour_guest.update(num_guests: params[:num_guests], user_id: params[:user_id][:id])
      redirect_to tour_path(@tour)
    else
      render "/tours/#{@tour.id}/edit_tour/#{@guest.id}"
    end
  end

  def approve_tour
    tour = Tour.find(params[:id])
    tour.toggle(:is_approved)
    if tour.save
      # abstract this away!!
      payments = tour.calculate_payment
      payments.each do |payment|
        Payment.create(amount: payment[:payment], user_id: payment[:user_id], tour_id: tour.id)
      end
      redirect_to tours_path
    else
      flash[:error] = "Error approving tour. Please try again."
      redirect_to tour_path(tour)
    end
  end

  private

  def tour_params
    params.require(:tour).permit(:location_id, :date, :start_time, :base_price, :is_private, [:user_ids])
  end

end
