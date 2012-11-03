# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jqame_reputation_point, :class => 'ReputationPoint' do
    elector_id 1
    question_id 1
    reputation_amount 1
    action 1
  end
end
