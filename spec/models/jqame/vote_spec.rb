require 'spec_helper'

describe Jqame::Vote do

  describe 'Associations' do
    let(:vote) { FactoryGirl.create(:jqame_vote) }
    let(:answer_vote) { FactoryGirl.create(:jqame_vote_on_answer) }

    it { should belong_to :votable }
    it { should belong_to :elector }

    describe 'Votable' do
      specify { vote.votable.should be_an_instance_of(Jqame::Question) }
      specify { answer_vote.votable.should be_an_instance_of(Jqame::Answer) }
    end
  end

  describe 'Methods' do
    let(:downvote) { FactoryGirl.create(:jqame_downvote) }
    let(:vote)     { FactoryGirl.create(:jqame_vote) }

    it 'verifies that #downvote? works as expected' do
      downvote.should be_downvote
      vote.should_not be_downvote
    end

    it 'verifies that #votable attribute is available for mass-assigment because of defined #votable=' do
      votable = vote.votable
      vote = described_class.new(votable: votable)

      vote.votable_id.should == votable.id
      vote.votable_type.should == votable.class.model_name
    end

    it 'verifies that #reputation_value returns an expected value' do
      downvote.reputation_value.should == described_class.rates[:question][:downvote]
      vote.reputation_value.should     == described_class.rates[:question][:upvote]
    end

    describe 'Class methods' do
    end
  end

  describe 'Scopes' do
    describe '#on' do
      before do
        @elector = FactoryGirl.create(:elector)
      end
      it 'verifies that scope returns an expected set of records' do
        vote = FactoryGirl.create(:jqame_vote, elector: @elector)

        @elector.votes.on(vote.votable).should include(vote)
      end

      it 'verifies that #affecting_votables_of works as expected' do
        other_elector = FactoryGirl.create(:elector)
        elector_votables = [ FactoryGirl.create(:jqame_question, elector: @elector), FactoryGirl.create(:jqame_answer, elector: @elector) ]
        random_votables = [ FactoryGirl.create(:jqame_question), FactoryGirl.create(:jqame_answer) ]

        votes = elector_votables.map { |votable| other_elector.vote_for! votable }
        random_votables.each          { |votable| other_elector.vote_for! votable }

        described_class.affecting_votables_of(@elector).sort.should == votes.sort
      end

      it 'verifies that #affecting_votables_by_date works as expected' do
        electors, expected_votes = [], []
        5.times { electors << FactoryGirl.create(:elector) }

        question = FactoryGirl.create(:jqame_question, elector: @elector)
        electors.each { |elector| expected_votes << elector.vote_for!(question) }

        expected_votes.pop.update_attribute(:created_at, Date.yesterday)
        described_class.affecting_votables_by_date(@elector, Time.now.utc.to_date).sort.should == expected_votes.sort
      end
    end
  end

  describe 'Callbacks' do
    before do
      @elector = FactoryGirl.create(:elector)
      @question = FactoryGirl.create(:jqame_question)
    end

    it 'updates current_rating of #votable upon vote' do
      @question.current_rating.should be_zero

      @elector.vote_for! @question
      @question.reload.current_rating.should == 1

      @elector.vote_against! @question
      @question.reload.current_rating.should == -1

      elector_b = FactoryGirl.create(:elector)
      elector_b.vote_for! @question
      @question.reload.current_rating.should be_zero

      elector_b.vote_against! @question
      @question.reload.current_rating.should == -2
    end

    it 'updated votable`s owner reputation upon vote' do
      author = @question.elector
      author.reputation.should be_zero

      @elector.vote_for! @question
      author.reload.reputation.should == described_class.rates[:question][:upvote]

      @elector.vote_against! @question
      author.reload.reputation.should == described_class.rates[:question][:downvote]

      elector_b = FactoryGirl.create(:elector)
      elector_b.vote_for! @question
      author.reload.reputation.should == ( described_class.rates[:question][:downvote] + described_class.rates[:question][:upvote] )

      elector_b.vote_against! @question
      author.reload.reputation.should == ( described_class.rates[:question][:downvote] * 2 )
    end
  end

end
