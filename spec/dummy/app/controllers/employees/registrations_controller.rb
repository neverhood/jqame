class Employees::RegistrationsController < Devise::RegistrationsController

  private

  def resource_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation)
  end

end
