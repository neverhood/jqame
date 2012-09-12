require 'spec_helper'

describe Jqame::Vote do

  describe 'Associations' do
    let(:vote) { FactoryGirl.create(:jqame_vote) }

    it { should belong_to :votable }
    it { should belong_to :employee }
    it 'verifies that votable is of a correct class' do
      vote.votable.should be_an_instance_of(Jqame::Question)
    end
  end

  describe 'Methods' do
  end

end
