# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "elector-#{n}@jobsite.com"
  end

  factory :elector, class: Jqame.elector_class do
    email
    password              '123456'
    password_confirmation '123456'
    name                  'Jobsite Employee'
  end
end
