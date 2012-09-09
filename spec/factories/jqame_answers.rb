# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_answer, :class => 'Answer' do
    body "MyText"
    full false
    current_rating 1
    question_id 1
  end
end
