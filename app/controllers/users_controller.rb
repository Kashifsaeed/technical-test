class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user

  def index
  end

  def new
    @user = User.new(role: :user)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_index_path,notice: 'User created successfully!'
    else
      render :new
    end
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    ## bypass password presence on update
    @user.skip_password_validation = true
    
    if @user.update(user_params)
      redirect_to admin_index_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_index_path
  end

  


  private

    ## secure params
    def user_params
      params.require(:user).permit(:role,:name,:email,:username,:password,:password_confirmation)
    end

    ## redirect back, if user
    ## is not an admin
    def check_user
      redirect_to :back, warning: "You don't have permission to access this action!" if current_user.user?
    end
end
