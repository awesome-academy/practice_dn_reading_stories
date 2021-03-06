class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create] #only: [:index, :edit, :update, :destroy]
  before_action :load_user, except: [:index, :create, :new] # only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :admin_user, only: [:destroy, :index]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Truyen Hot!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    else
      flash[:warning] = "co loi xay ra khi xoa user"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password,:password_confirmation)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = "KHong tim thay user"
    redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user) || current_user.role == 1
  end

  def admin_user
    redirect_to(root_url) unless current_user.role == 1
  end
end
