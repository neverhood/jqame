# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_vote, :class => 'Jqame::Vote' do
    association :votable, :factory => :jqame_question
    association :elector
  end

  factory :jqame_downvote, class: 'Jqame::Vote' do
    association :votable, :factory => :jqame_question
    association :elector
    upvote      false
  end

  factory :jqame_vote_on_answer, class: 'Jqame::Vote' do
    association :votable, :factory => :jqame_answer
    association :elector
  end
end
