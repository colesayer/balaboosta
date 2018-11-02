class SessionController < ApplicationController
  skip_before_action :login_required, :verify_authenticity_token

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      login(@user)
      redirect_to user_path(@user)
    else
      flash[:error] = "Invalid email or password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
