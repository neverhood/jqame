require 'spec_helper'

describe 'Votables' do
  include ElectorAuthentication

  let(:elector) { FactoryGirl.create(:elector) }
  let(:question) { FactoryGirl.create(:jqame_question) }
  let(:answer) { FactoryGirl.create(:jqame_answer, question: question) }

  context 'Elector signed in' do
    before do
      sign_in elector
    end

    it 'upvotes votables' do
      visit jqame.question_path(question)

      within 'div#question div.suffrage' do
        find('.upvote').click
        question.reload.current_rating.should == 1

        find('.downvote').click
        question.reload.current_rating.should == -1

        find('.cancel-vote').click
        question.reload.current_rating.should be_zero
      end
    end
  end

  context 'Elector not signed in' do
    it 'does not see vote links' do
      visit jqame.question_path(question)

      within 'div#question div.suffrage' do
        should_not have_selector('.upvote')
        should_not have_selector('.cancel-vote')
        should_not have_selector('.downvote')
      end
    end
  end

end
