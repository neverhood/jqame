require 'spec_helper'

describe 'SuffrageReputationLogic' do

  context 'Anwer accept or unaccept' do
    let(:question) { FactoryGirl.create(:jqame_question) }
    let(:answer) { FactoryGirl.create(:jqame_answer, question: question) }

    describe 'Question owner accepts his own answer' do
      it 'won`t grant reputation points' do
        @answer = FactoryGirl.create(:jqame_answer, elector: question.elector, question: question)
        Jqame::SuffrageReputationLogic.answer_accepted! question, @answer

        question.elector.reload.reputation.should be_zero
      end

      specify 'reputation is withdrawn upon downvote' do
        vote = answer.elector.vote_against!(question)

        answer.elector.reload.reputation.should == Jqame::ActionRate.new(:downvoted).rate
        question.elector.reload.reputation.should == Jqame::VoteRate.new(vote).rate
      end
    end

    describe 'Question owner accepts and unaccepts answer' do
      it 'grants and withdraws reputation points to both question and answer owner' do
        Jqame::SuffrageReputationLogic.answer_accepted! question, answer

        answer.elector.reload.reputation.should == Jqame::ActionRate.new(:accepted).rate
        question.elector.reload.reputation.should == Jqame::ActionRate.new(:accept).rate

        Jqame::SuffrageReputationLogic.answer_unaccepted! question, answer

        answer.elector.reload.reputation.should be_zero
        question.elector.reload.reputation.should be_zero
      end
    end

  end

end
