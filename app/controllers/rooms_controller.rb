class RoomsController < ApplicationController
  before_action :set_room, only: [:edit,:update,:show,:destroy]
  before_action :require_user, except: [:show,:index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @rooms = Room.paginate(page: params[:page],per_page:5)
  end
  
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    @room.user = User.first
    if @room.save
      flash[:success]="The post was successfully created"
      redirect_to room_path(@room)
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @room.update(room_params)
      flash[:success] = "The post was successfully updated"
      redirect_to room_path(@room)
    else
      render 'edit'
    end
  end
  
  def destroy
    @room.destroy
    flash[:success] = "The post was successfully deleted"
    redirect_to rooms_path
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end
    
    def room_params
      params.require(:room).permit(:title,:description)
    end
    
    def require_same_user
      if current_user != @room.user
        flash[:danger]="You can only edit or delete your own articles."
        redirect_to root_path
      end
    end
end