class Employees::PasswordsController < Devise::PasswordsController

  private

  def resource_params
    params.require(:employee).permit(:email, :password, :password_confirmation)
  end

end
