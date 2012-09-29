require 'spec_helper'

describe Jqame::Vote do

  describe 'Associations' do
    let(:vote) { FactoryGirl.create(:jqame_vote) }
    let(:answer_vote) { FactoryGirl.create(:jqame_vote_on_answer) }

    it { should belong_to :votable }
    it { should belong_to :employee }

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
        @employee = FactoryGirl.create(:employee)
      end
      it 'verifies that scope returns an expected set of records' do
        vote = FactoryGirl.create(:jqame_vote, employee: @employee)

        @employee.votes.on(vote.votable).should include(vote)
      end

      it 'verifies that #affecting_votables_of works as expected' do
        other_employee = FactoryGirl.create(:employee)
        employee_votables = [ FactoryGirl.create(:jqame_question, employee: @employee), FactoryGirl.create(:jqame_answer, employee: @employee) ]
        random_votables = [ FactoryGirl.create(:jqame_question), FactoryGirl.create(:jqame_answer) ]

        votes = employee_votables.map { |votable| other_employee.vote_for! votable }
        random_votables.each          { |votable| other_employee.vote_for! votable }

        described_class.affecting_votables_of(@employee).sort.should == votes.sort
      end

      it 'verifies that #affecting_votables_by_date works as expected' do
        employees, expected_votes = [], []
        5.times { employees << FactoryGirl.create(:employee) }

        question = FactoryGirl.create(:jqame_question, employee: @employee)
        employees.each { |employee| expected_votes << employee.vote_for!(question) }

        expected_votes.pop.update_attribute(:created_at, Date.yesterday)
        described_class.affecting_votables_by_date(@employee, Time.now.utc.to_date).sort.should == expected_votes.sort
      end
    end
  end

  describe 'Callbacks' do
    before do
      @employee = FactoryGirl.create(:employee)
      @question = FactoryGirl.create(:jqame_question)
    end

    it 'updates current_rating of #votable upon vote' do
      @question.current_rating.should be_zero

      @employee.vote_for! @question
      @question.reload.current_rating.should == 1

      @employee.vote_against! @question
      @question.reload.current_rating.should == -1

      employee_b = FactoryGirl.create(:employee)
      employee_b.vote_for! @question
      @question.reload.current_rating.should be_zero

      employee_b.vote_against! @question
      @question.reload.current_rating.should == -2
    end

    it 'updated votable`s owner reputation upon vote' do
      author = @question.employee
      author.reputation.should be_zero

      @employee.vote_for! @question
      author.reload.reputation.should == described_class.rates[:question][:upvote]

      @employee.vote_against! @question
      author.reload.reputation.should == described_class.rates[:question][:downvote]

      employee_b = FactoryGirl.create(:employee)
      employee_b.vote_for! @question
      author.reload.reputation.should == ( described_class.rates[:question][:downvote] + described_class.rates[:question][:upvote] )

      employee_b.vote_against! @question
      author.reload.reputation.should == ( described_class.rates[:question][:downvote] * 2 )
    end
  end

end
