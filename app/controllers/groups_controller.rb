class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path
  end

  def add_guest
    @group = Group.find_by(id: params[:id])
    @group_guest = GroupGuest.new(guest_id: params[:guest][:id], group_id: params[:id], user_id: params[:user_id][:id])

    if @group_guest.save
      redirect_to group_path(params[:id])
    else
      redirect_to groups_path
    end
  end

  def remove_guest
    guest = Guest.all.find(params[:guest_id])
    guest_group = guest.group_guests.find_by(group_id: params[:id])
    guest_group.destroy
    redirect_to group_path(params[:id])
  end

  def add_tour
    binding.pry
    @tour_guest = TourGuest.new(guest_id: params[:id], tour_id: params[:tour][:id], num_guests: params[:num_guests], user_id: params[:user_id][:id])
    if @tour_guest.save
      redirect_to guest_path(params[:id])
    else
      redirect_to guests_path
    end
  end


  def append_note_group
    @group = Group.find_by(id: params[:id])
    @user = current_user
    @comment = Comment.new(content: params[:content], is_important: params[:is_important], noteable: @group, user_id: @user.id)
    if @comment.save
      redirect_to group_path(@group)
    else
      flash[:error] = "Error adding note. Please try again."
      redirect_to group_path(@group)
    end
  end

  def remove_note_group
    comment = Comment.all.find_by(id: params[:comment_id])
    comment.destroy
    redirect_to group_path(params[:id])
  end

  def add_guest
    @group = Group.find_by(id: params[:id])
    @group_guest = GroupGuest.new(guest_id: params[:guest][:id], group_id: params[:id], user_id: params[:user_id][:id])
    # subtotal = calculateAmountOwed(@tour, @tour_guest)
    # @tour_guest.amount_owed = subtotal

    if @group_guest.save
      redirect_to group_path(params[:id])
    else
      redirect_to groups_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :tour_ids, :guest_ids)
  end



end
