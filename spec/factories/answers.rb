# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_answer, :class => 'Jqame::Answer' do
    association :question, :factory => :jqame_question

    body "Answer"
    full true
  end
end
