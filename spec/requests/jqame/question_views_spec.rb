require 'spec_helper'

describe 'QuestionView' do
  include ElectorAuthentication

  let(:elector) { FactoryGirl.create(:elector) }
  let(:question) { FactoryGirl.create(:jqame_question) }

  context 'Elector has not signed in' do
    it 'won`t store record for unsigned elector' do
      visit jqame.question_path(question)
      question.question_views.count.should be_zero
    end
  end

  context 'Elector signed in' do

    before { sign_in elector }

    describe 'With existing record' do
      before { FactoryGirl.create(:jqame_question_view, question: question, elector: elector) }

      it 'won`t store duplicate record' do
        question.question_views.count.should == 1

        visit jqame.question_path(question)
        question.question_views.count.should == 1
      end
    end

    describe 'With not existing record' do
      it 'stores new record upon accessing question' do
        question.question_views.count.should be_zero

        visit jqame.question_path(question)
        question.question_views.count.should == 1
      end
    end

  end

end
