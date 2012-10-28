# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_question_view, :class => 'Jqame::QuestionView' do
    association :question, :factory => :jqame_question
    association :elector
  end
end
