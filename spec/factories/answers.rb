# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_answer, class: 'Jqame::Answer' do
    association :question, :factory => :jqame_question
    association :employee

    body "Answer"
  end
end
