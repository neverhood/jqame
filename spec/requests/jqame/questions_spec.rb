require 'spec_helper'

describe 'Questions' do
  include ElectorAuthentication

  before do
    @question = FactoryGirl.create(:jqame_question)
  end

  context 'Elector signed in' do
  end

  context 'Elector not signed in' do
  end

  context 'Stateless' do
    it 'visits questions#index page and looks for expected elements' do
      visit jqame.questions_path

      page.should have_selector('div#questions')
      page.should have_content  @question.title
    end
  end

end
