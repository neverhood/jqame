# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "employee-#{n}@jobsite.com"
  end

  factory :employee, :class => 'Employee' do
    email
    password              '123456'
    password_confirmation '123456'
    name                  'Jobsite Employee'
  end
end
