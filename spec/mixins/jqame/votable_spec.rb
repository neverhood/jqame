describe 'Votable' do

  describe 'Shared' do
    describe 'Methods' do
      describe '#comment_with' do
        before do
          @question = FactoryGirl.build(:jqame_question)
          @comment = FactoryGirl.build(:jqame_comment, votable: @question)
        end

        it 'should save and return comment if valid params were given' do
          @question.comment_with(body: @comment.body).should(be_persisted)
          @question.comments.count.should == 1
        end

        it 'should return a comment with #errors if invalid params were given' do
          @question.comment_with(body: '').errors.should_not be_empty
        end
      end
    end
  end

  describe 'Question' do
    before do
      @question = FactoryGirl.create(:jqame_question)
    end

    it 'verifies that associated comments are destroyed' do
      comment = FactoryGirl.create(:jqame_comment, votable: @question)
      @question.destroy

      Jqame::Comment.count.should be_zero
    end

    describe 'Scopes' do
      describe '#top' do
        before do
          @questions = [ @question, FactoryGirl.create(:jqame_question, current_rating: 10),
                         FactoryGirl.create(:jqame_question, current_rating: 20) ]
        end

        it 'returns questions ordered by #current_rating' do
          Jqame::Question.top.should == @questions.reverse
        end
      end
    end
  end

  describe 'Answer' do
    before do
      @answer = FactoryGirl.create(:jqame_answer)
    end

    it 'verifies that associated comments are destroyed' do
      comment = FactoryGirl.create(:jqame_comment, votable: @answer)
      @answer.destroy

      Jqame::Comment.count.should be_zero
    end

    describe 'Scopes' do
      describe '#top' do
        before do
          @answers = [ @answer, FactoryGirl.create(:jqame_answer, current_rating: 10),
                       FactoryGirl.create(:jqame_answer, current_rating: 20) ]
        end

        it 'returns answers ordered by #current_rating' do
          Jqame::Answer.top.should == @answers.reverse
        end
      end
    end
  end

end
