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
      end
    end
  end

end
