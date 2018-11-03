class UsersController < ApplicationController
  before_action :admin_required, except: [:current_user_home, :homepage, :show, :edit, :update, :edit_password, :update_password], if: :params_match_user?

  def index
      @users = User.all
  end

  def current_user_home
    redirect_to homepage_path(current_user)
  end

  def homepage
    @user = User.find(params[:id])
    @tours = Tour.all
  end

  def show
    if !is_admin? && current_user.id.to_s != params[:id]
      redirect_to homepage_path(current_user)
    else
      @user = User.find(params[:id])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user && @user.authenticate(params[:user][:old_password])
      if params[:user][:password] == params[:user][:password_confirmation]
        @user.update(password: params[:user][:password])
        redirect_to user_path(@user), notice: "Your password has been updated."

      else
        redirect_to change_password_path(@user), notice: "Passwords must match."
      end
    else
      redirect_to change_password_path(@user), notice: "Incorrect Password."
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :old_password, :password, :password_confirmation, [:role_ids])
  end

end
