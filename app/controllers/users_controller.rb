class UsersController < ApplicationController

before_action :set_user, only: [:edit, :update, :show]
before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page],per_page:5)
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Cadorent #{@user.username}"
      redirect_to rooms_path
    else
      render 'new'
    end
  end
  
  def show
    @user_rooms = @user.rooms.paginate(page: params[:page], per_page:5)
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to rooms_path
    else
      render 'edit'
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:username,:email,:password)
    end
    
    def require_same_user
      if current_user != @user
        flash[:danger]="You can only edit your profile."
        redirect_to root_path
      end
    end
end