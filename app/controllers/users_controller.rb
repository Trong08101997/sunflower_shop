class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update]

  def new
    @user = User.new
    @submit = true
  end

  def index
    @users = User.infor_user.order(id: :asc).page(params[:page]).per_page(Settings.perpage)
  end

  def show;end

  def create
    @user = User.new user_params
    if @user.save
      logn_in @user
      flash[:success] = t"controllers.users_controller.Register_success"
      redirect_to @user
    else
      flash[:success] = t"controllers.users_controller.Register_failed"
      render :new
    end
  end

  def edit;end

  def update
    if @user.update_attributes user_params
      logn_in @user
      flash[:success] = t "controllers.users.success_update"
      redirect_to @user
    else
       render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password, :address, :sex, :phone_number,
      :password_confirmation
  end

  def load_user
    @user = User.find_by_id params[:id]
    return if @user
      flash[:danger] = t"controllers.users_controller.not_the_user"
      redirect_to user
  end
end
