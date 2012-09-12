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
  end

  describe 'Methods' do
    describe '#answer_with' do
      before do
        @question = FactoryGirl.build(:jqame_question)
        @answer = FactoryGirl.build(:jqame_answer, question: @question)
      end

      it 'should save and return an answer if valid params were given' do
        @question.answer_with(body: @answer.body).should(be_persisted)
        @question.answers.count.should == 1
      end

      it 'should return an answer with #errors if invalid params were given' do
        @question.answer_with(body: '').errors.should_not be_empty
      end
    end
  end

end
