require 'spec_helper'

describe Jqame::Question do

  describe 'Validations' do
    subject { FactoryGirl.build(:jqame_question) }

    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe 'Associations' do
    it { should have_many(:answers) }
    it { should have_many(:votes) }
    it { should have_many(:comments) }

    it 'ensures associated answers are destroyed' do
      answer = FactoryGirl.create(:jqame_answer)
      answer.question.destroy

      Jqame::Answer.count.should be_zero
    end
  end

  describe 'Methods' do
    describe '#answer_with' do
      before do
        @question = FactoryGirl.build(:jqame_question)
        @answer = FactoryGirl.build(:jqame_answer, question: @question)
        @elector = FactoryGirl.create(:elector)
      end

      it 'should save and return an answer if valid params were given' do
        @question.answer_with(@elector, body: @answer.body).should(be_persisted)
        @question.answers.count.should == 1
      end

      it 'should return an answer with #errors if invalid params were given' do
        @question.answer_with(@elector, body: '').errors.should_not be_empty
      end
    end
  end

end
