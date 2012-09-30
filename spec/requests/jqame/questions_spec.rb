require 'spec_helper'

describe 'Questions' do
  include VotableSpecHelper
  include ElectorAuthentication

  let(:elector) { FactoryGirl.create(:elector) }
  let(:question) { FactoryGirl.create(:jqame_question, elector: elector) }

  before do
    @question = FactoryGirl.create(:jqame_question)
  end

  context 'Elector signed in' do
    before { sign_in elector }

    it 'ensures that elector is able to create a question' do
      question = FactoryGirl.build(:jqame_question, elector: elector)
      submit_new_question(question)

      page.should have_content(question.title)
    end

    context 'Votable owner' do
      it 'ensures that elector to edit his question' do
        visit jqame.edit_question_path(question)
        new_question_attributes = { title: 'New question title', body: 'New question body' }

        update_question(new_question_attributes)
        page.should have_content(new_question_attributes[:title])
      end
    end

    context 'Not votable owner' do
      it 'ensures that elector can`t edit a question that has been created by someone else' do
        visit jqame.edit_question_path(@question)
        current_path.should == root_path
      end
    end
  end

  context 'Elector not signed in' do
    it 'ensures that elector will be redirected to sign_in page when he attempts to create new question' do
      visit jqame.questions_path

      click_link I18n.t('jqame.questions.index.ask_question')
      current_path.should == send(:"new_#{Jqame.elector_string}_session_path")
    end
  end

  context 'Stateless' do
    it 'ensures expected elements on questions#index are in place' do
      visit jqame.questions_path

      page.should have_selector('div#questions')
      page.should have_content(@question.title)
    end

    it 'ensures that user is able to access the question#show page' do
      visit jqame.question_path(question)

      current_path.should == jqame.question_path(question)
      page.should have_content(question.title)
    end
  end

end
