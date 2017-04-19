#
class RegistrationsController < Devise::RegistrationsController

  # before_filter :configure_account_update_params, only: [:update]
  # def configure_account_update_params
  #     devise_parameter_sanitizer.for(:user) << :phone
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.create(create_params)
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def create_params
    params.require(:user).permit(:name, :dob, :gender, :address, :phone, :role, :email, :password, :password_confirmation)
  end

end
