describe 'Suffrage' do

  before do
    @employee = FactoryGirl.create(:employee)
  end

  let(:question) { FactoryGirl.create(:jqame_question) }
  let(:answer)   { FactoryGirl.create(:jqame_answer, question: question) }

  describe 'Employee' do
    subject { @employee }

    it { should have_many(:questions) }
    it { should have_many(:answers) }
    it { should have_many(:votes) }

    describe 'Methods' do

      describe 'Not votable owner ( not an author of votable )' do
        it { should_not be_votable_author(question) }

        context 'With existing upvote' do
          before { @employee.vote_for! question }

          it { should be_able_to_vote_against(question) }
          it { should_not be_able_to_vote_for(question) }
          it 'has voted for question' do
            @employee.voted_for?(question).should be_true
          end
          it 'has voted on question' do
            @employee.voted_on?(question).should be_true
          end
          it 'cancels upvote upon downvote' do
            @employee.vote_against! question
            @employee.voted_for?(question).should be_false
            @employee.voted_against?(question).should be_true
            @employee.votes.on(question).count.should == 1
          end
        end

        context 'With existing downvote' do
          before { @employee.vote_against! question }

          it { should be_able_to_vote_for(question) }
          it { should_not be_able_to_vote_against(question) }
          it 'has voted against question' do
            @employee.voted_against?(question).should be_true
          end
          it 'has voted on question' do
            @employee.voted_on?(question).should be_true
          end
          it 'cancels downvote upon upvote' do
            @employee.vote_for! question
            @employee.voted_for?(question).should be_true
            @employee.voted_against?(question).should be_false
            @employee.votes.on(question).count.should == 1
          end
        end

        context 'Wihout existing vote' do
          it 'has not voted on question' do
            @employee.voted_on?(question).should be_false
          end
          it { should be_able_to_vote_for(question) }
          it { should be_able_to_vote_against(question) }
        end
      end

      describe 'Votable owner' do
        subject { question.employee }

        it { should be_votable_author(question) }
        it { should_not be_able_to_vote_for(question) }
        it { should_not be_able_to_vote_against(question) }

        it 'verifies that #dates_when_reputation_changed returns an expected dates' do
          expected_dates = (1..5).map { |num| num.days.ago }
          expected_dates.each do |date|
            vote = FactoryGirl.create(:jqame_vote, votable: question)
            vote.update_attribute(:created_at, date)
          end

          subject.dates_when_reputation_changed.sort.should == expected_dates.map(&:to_date).sort
        end
      end

    end
  end

end
