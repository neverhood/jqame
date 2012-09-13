require 'spec_helper'

describe Jqame::Vote do

  describe 'Associations' do
    let(:vote) { FactoryGirl.create(:jqame_vote) }
    let(:answer_vote) { FactoryGirl.create(:jqame_vote_on_answer) }

    it { should belong_to :votable }
    it { should belong_to :employee }
    it 'verifies that votable is of a #question class' do
      vote.votable.should be_an_instance_of(Jqame::Question)
    end
    it 'verifies that votable is of a #answer class' do
      answer_vote.votable.should be_an_instance_of(Jqame::Answer)
    end
  end

  describe 'Methods' do
    let(:downvote) { FactoryGirl.create(:jqame_downvote) }
    let(:vote) { FactoryGirl.create(:jqame_vote) }

    it 'verifies that #downvote? works as expected' do
      downvote.should be_downvote
      vote.should_not be_downvote
    end
  end

end
