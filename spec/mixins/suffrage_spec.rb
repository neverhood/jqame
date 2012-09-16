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
      describe 'Not votable owner' do
        subject { @employee }

        it { should be_able_to_vote_for(question) }
        it { should be_able_to_vote_for(answer)   }
      end

      describe 'Votable owner' do
        context 'Question' do
          subject { question.employee }
          it { should_not be_able_to_vote_for(question) }
        end

        context 'Answer' do
          subject { answer.employee }
          it { should_not be_able_to_vote_for(answer) }
        end
      end
    end
  end

end
