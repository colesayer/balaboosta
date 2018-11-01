class GuestsController < ApplicationController

  def index
    @guests = Guest.all
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)

    if @guest.save
      redirect_to guest_path(@guest)
    else
      render :new
    end
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def update
    @guest = Guest.find(params[:id])
    if @guest.update(guest_params)
      redirect_to guest_path(@guest)
    else
      render :edit
    end
  end

  def destroy
    Guest.find(params[:id]).destroy
    redirect_to guests_path
  end

  def add_tour
    @tour_guest = TourGuest.new(guest_id: params[:id], tour_id: params[:tour][:id], num_guests: params[:num_guests], user_id: params[:user_id][:id])
    if @tour_guest.save
      redirect_to guest_path(params[:id])
    else
      redirect_to guests_path
    end
  end

  def edit_tour
    @guest = Guest.find_by(id: params[:id])
    @tour = Tour.find_by(id: params[:tour_id])
    @tour_guest = @guest.tour_guests.find_by(tour_id: @tour.id)
  end

  def update_tour
    @guest = Guest.find_by(id: params[:id])
    @tour = Tour.find_by(id: params[:tour_id])
    @tour_guest = @guest.tour_guests.find_by(tour_id: @tour.id)
    if @tour_guest.update(num_guests: params[:num_guests], user_id: params[:user_id][:id])
      redirect_to guest_path(@guest)
    else
      render "/guests/#{@guest.id}/edit_tour/#{@tour.id}"
    end
  end

  def remove_tour
    guest = Guest.all.find(params[:id])
    guest_tour = guest.tour_guests.find_by(tour_id: params[:tour_id])
    guest_tour.destroy
    redirect_to guest_path(guest)
  end


  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :email, :phone, :tour_ids)
  end

  def tour_params
    params.require(:guest).permit(:tour, :num_guests)
  end

end
