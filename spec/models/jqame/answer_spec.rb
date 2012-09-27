require 'spec_helper'

describe Jqame::Answer do

  describe 'Validations' do
    let(:answer) { FactoryGirl.build(:jqame_answer) }
    let(:comment) { FactoryGirl.build(:jqame_comment) }

    it 'verifies that answer has different body length depending on a type' do
      comment.should_not allow_value('Too long for a comment' * 10).for(:body)
      comment.should allow_value('Comment').for(:body)

      answer.should allow_value('Not too long for an answer').for(:body)
    end

  end

  describe 'Associations' do
    it { should belong_to(:question) }
    it { should have_many(:votes) }
  end

  describe 'Methods' do
    let(:answer) { FactoryGirl.create(:jqame_answer) }
    let(:comment) { FactoryGirl.create(:jqame_comment) }

    it 'verifies that answer is a full answer' do
      answer.should be_answer
      comment.should_not be_answer
    end

    it 'verifies that short answer is treated like a comment' do
      comment.should be_comment
      answer.should_not be_comment
    end
  end

  describe 'Scopes' do
    describe '#top' do
      before do
        @answers = [ FactoryGirl.create(:jqame_answer), FactoryGirl.create(:jqame_answer, current_rating: 10),
                     FactoryGirl.create(:jqame_answer, current_rating: 20) ]
      end

      it 'returns answers ordered by #current_rating' do
        described_class.top.should == @answers.reverse
      end
    end
  end

end
