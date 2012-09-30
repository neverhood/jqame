require 'spec_helper'

describe 'Answers' do
  include VotableSpecHelper
  include ElectorAuthentication

  let(:elector) { FactoryGirl.create(:elector) }
  let(:question) { FactoryGirl.create(:jqame_question, elector: elector) }
  let(:answer)  { FactoryGirl.build(:jqame_answer, elector: elector, question: question) }

  before { @answer = FactoryGirl.create(:jqame_answer) }

  context 'Elector Signed in' do
    before { sign_in elector }

    it 'ensures that elector is able to post an answer to existing question' do
      visit jqame.question_path(question)
      fill_in 'answer_body', with: answer.body
      click_button I18n.t('jqame.answers.form.submit')

      page.should have_content(answer.body)
      current_path.should == jqame.question_path(question)
    end

    it 'ensures that elector is able to edit his answer' do
      answer.save
      new_answer_body = answer.body + ' NEW '
      visit jqame.question_path(question)

      within "div#answer-#{answer.id}" do
        click_link I18n.t('jqame.answers.answer.edit')
      end

      fill_in 'answer_body', with: new_answer_body
      click_button I18n.t('jqame.answers.form.submit')
      current_path.should == jqame.question_path(question)
      page.should have_content(new_answer_body)
    end

    it 'ensures that elector is able to destroy his answer' do
      answer.save
      visit jqame.question_path(question)

      within "div#answer-#{answer.id}" do
        click_link I18n.t('jqame.answers.answer.destroy')
      end

      current_path.should == jqame.question_path(question)
      page.should_not have_content(answer.body)
    end
  end

  context 'Elector has not signed in' do
    it 'ensures unsigned elector can`t post answers' do
      visit jqame.question_path(question)

      page.should_not have_css('form#new-answer')
    end

    it 'ensures unsigned elector can`t edit answers' do
      visit jqame.edit_question_answer_path(question_id: @answer.question_id, id: @answer)

      current_path.should == send(:"new_#{Jqame.elector_string}_session_path")
    end
  end
end
