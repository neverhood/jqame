require 'spec_helper'

describe 'FavoritedQuestions' do
  include ElectorAuthentication

  let(:question) { FactoryGirl.create(:jqame_question) }

  before { sign_in question.elector }

  it 'adds and removes from favorites' do
    visit jqame.question_path(question)

    find('.add-to-favorites').click
    find('.times-favorited').text.should include('1')

    find('.remove-from-favorites').click
    find('.times-favorited').text.should include('0')
  end
end
