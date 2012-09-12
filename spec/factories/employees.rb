# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee, :class => 'Employee' do
    email                 'employee@jobsite.com'
    password              '123456'
    password_confirmation '123456'
    name                  'Jobsite Employee'
  end
end
