class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :login_required
  helper_method :current_user, :logged_in?, :is_admin?, :is_tour_guide?, :is_booking?, :params_match_user?

  def login_required
    if !logged_in?
      return redirect_to login_path
    end
  end

  def logged_in?
    !!session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def admin_required
    if !is_admin?
      return redirect_to homepage_path(current_user)
    end
  end

  def is_admin?
    return current_user.roles[0].title == "Admin"
  end

  def params_match_user?
    return params[:id] == current_user[:id].to_s
  end

  def is_tour_guide?(user)
    return user.roles.any? {|role| role[:title] == "TourGuide"}
  end

  def is_booking?
    return current_user.roles[0].title == "Booking"
  end


end
