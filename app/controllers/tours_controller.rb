class ToursController < ApplicationController

  def index
    @tours = if params[:location_filter]
      Tour.where(location_id: params[:location_filter][:location_id])
    else
      Tour.all
    end
    @upcoming_tours = @tours.upcoming
    @past_tours_needs_approval = @tours.past_needs_approval
    @past_tours_approved = @tours.past_approved
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
    convert_date_time(params[:tour][:start_time_time], params[:tour][:start_time_date])
    @tour = Tour.new(tour_params)
    @tour.save
    redirect_to tour_path(@tour)
  end

  def edit
    @tour = Tour.find(params[:id])
    @users = User.role("TourGuide")
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
    if @tour_guest.update(num_guests: params[:num_guests], user_id: params[:user_id][:id], is_confirmed: params[:is_confirmed], is_cancelled: params[:is_cancelled])
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

  def append_note_tour
    @tour = Tour.find_by(id: params[:id])
    @comment = Comment.new(content: params[:content], is_important: params[:is_important], noteable: @tour)
    if @comment.save
      redirect_to tour_path(@tour)
    else
      flash[:error] = "Error adding note. Please try again."
      redirect_to tour_path(@tour)
    end
  end

  def remove_note_tour
    comment = Comment.all.find_by(id: params[:comment_id])
    comment.destroy
    redirect_to tour_path(params[:id])
  end

  def append_note_reservation
    @guest = Guest.find_by(id: params[:guest_id])
    @tour = Tour.find_by(id: params[:id])
    @tour_guest = @guest.tour_guests.find_by(tour_id: @tour.id)
    @comment = Comment.new(content: params[:content], is_important: params[:is_important], noteable: @tour_guest)
    if @comment.save
      redirect_to "/tours/#{@tour.id}/edit_tour/#{@guest.id}"
    else
      flash[:error] = "Error adding note. Please try again."
      redirect_to "/tours/#{@tour.id}/edit_tour/#{@guest.id}"
    end
  end

  def remove_note_reservation
    comment = Comment.all.find_by(id: params[:comment_id])
    comment.destroy
    redirect_to "/tours/#{params[:id]}/edit_tour/#{params[:guest_id]}"
  end

  private

  def tour_params
    params.require(:tour).permit(:id, :location_id, :date, :start_time, :base_price, :is_private, [:user_ids], :location_filter, :content, :is_important)
  end

  def convert_date_time(time, date)
    params[:tour][:start_time] = "#{date} #{time}"
  end

end
