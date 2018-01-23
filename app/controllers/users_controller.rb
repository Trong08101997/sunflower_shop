class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit]

  def new
    @user = User.new
  end

  def index
    @users = User.infor_user.order(id: :asc).page(params[:page]).per(Settings.perpage)
  end

  def show;end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t"controllers.users_controller.Register_success"
      redirect_to :show
    else
      flash[:success] = t"controllers.users_controller.Register_failed"
      render :new
    end
  end

  def edit;end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :address, :sex, :phone_number,
      :password_confirmation, :STT
  end

  def load_user
    @user = User.find_by_id params[:id]
    return if @user
      flash[:danger] = t"controllers.users_controller.not_the_user"
      redirect_to user
  end
end
