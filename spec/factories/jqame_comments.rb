# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_comment, :class => 'Jqame::Comment' do
    association :votable, :factory => :jqame_question
    association :elector
    body "Comment"
  end

  factory :jqame_comment_on_answer, class: 'Jqame::Comment' do
    association :votable, :factory => :jqame_answer
    association :elector
    body "Comment"
  end
end
