class UsersController < ApplicationController
before_action :set_user, :correct_user, only:[:edit, :update]

  def show
  @user = User.find(params[:id])
  @microposts = @user.microposts.order(created_at: :desc)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    # handle a successful update
    else
      render 'edit'
    end
  end
    
    private
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :username, :location, :about, :password,
                                   :password_confirmation)
    end
    def logged_in_user
      unless logged_in?
        flash[:danger]= "Please log in."
        store_location
        redirect_to login_url
      end  
    end 
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
