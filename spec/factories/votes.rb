# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_vote, :class => 'Jqame::Vote' do
    association :votable, :factory => :jqame_question
    association :employee
  end

  factory :jqame_vote_on_answer, class: 'Jqame::Vote' do
    association :votable, :factory => :jqame_answer
    association :employee
  end
end
