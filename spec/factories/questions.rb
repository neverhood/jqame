FactoryGirl.define do
  factory :question, class: 'Jqame::Question' do
    title 'Question'
    body  'What`s the meaning of life?'

    current_rating 0
  end
end
