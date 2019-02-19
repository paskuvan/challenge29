class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.find_by(email: params[:user][:email]).nil?
      @user.save
      if @user
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render :new
      end
    else
      redirect_to users_sign_up_path, alert: 'El correo ya está asociado'
    end
  end

  def histories
    @histories = helpers.current_user.histories
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
