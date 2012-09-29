describe 'Suffrage' do

  before do
    @elector = FactoryGirl.create(:elector)
  end

  let(:question) { FactoryGirl.create(:jqame_question) }
  let(:answer)   { FactoryGirl.create(:jqame_answer, question: question) }

  describe 'elector' do
    subject { @elector }

    it { should have_many(:questions) }
    it { should have_many(:answers) }
    it { should have_many(:votes) }

    describe 'Methods' do

      describe 'Not votable owner ( not an author of votable )' do
        it { should_not be_votable_author(question) }

        context 'With existing upvote' do
          before { @elector.vote_for! question }

          it { should be_able_to_vote_against(question) }
          it { should_not be_able_to_vote_for(question) }
          it 'has voted for question' do
            @elector.voted_for?(question).should be_true
          end
          it 'has voted on question' do
            @elector.voted_on?(question).should be_true
          end
          it 'cancels upvote upon downvote' do
            @elector.vote_against! question
            @elector.voted_for?(question).should be_false
            @elector.voted_against?(question).should be_true
            @elector.votes.on(question).count.should == 1
          end
        end

        context 'With existing downvote' do
          before { @elector.vote_against! question }

          it { should be_able_to_vote_for(question) }
          it { should_not be_able_to_vote_against(question) }
          it 'has voted against question' do
            @elector.voted_against?(question).should be_true
          end
          it 'has voted on question' do
            @elector.voted_on?(question).should be_true
          end
          it 'cancels downvote upon upvote' do
            @elector.vote_for! question
            @elector.voted_for?(question).should be_true
            @elector.voted_against?(question).should be_false
            @elector.votes.on(question).count.should == 1
          end
        end

        context 'Wihout existing vote' do
          it 'has not voted on question' do
            @elector.voted_on?(question).should be_false
          end
          it { should be_able_to_vote_for(question) }
          it { should be_able_to_vote_against(question) }
        end
      end

      describe 'Votable owner' do
        subject { question.elector }

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
