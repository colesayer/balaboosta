class ToursController < ApplicationController
  def index
    @upcoming_tours = Tour.where('date >= ?', Date.today).order(:date)
    @past_tours = Tour.where('date < ?', Date.today).order(:date)
  end

  def show
    @tour = Tour.find(params[:id])
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

  private

  def tour_params
    params.require(:tour).permit(:location_id, :date, :start_time, :base_price)
  end

end
