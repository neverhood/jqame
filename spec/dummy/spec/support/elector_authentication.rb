module ElectorAuthentication
  def sign_in employee
    visit new_employee_session_path

    fill_in "employee_email", with: employee.email rescue nil
    fill_in "employee_password", with: employee.password

    click_button I18n.t("employees.sign_in")
  end

  def sign_out
    click_link( I18n.t("employees.sign_out") ) if page.has_content?(I18n.t("employees.sign_out"))
  end
end
