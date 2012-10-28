# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_favorited_question, :class => 'FavoritedQuestion' do
    question_id 1
    elector_id 1
  end
end
