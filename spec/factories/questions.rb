FactoryGirl.define do
  sequence :title do |n|
    "Question Title #{n}"
  end

  factory :jqame_question, class: 'Jqame::Question' do
    title
    body  'What`s the meaning of life?'
  end
end
