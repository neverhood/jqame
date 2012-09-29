require 'spec_helper'

describe Jqame::Answer do

  describe 'Validations' do
    let(:answer) { FactoryGirl.build(:jqame_answer) }

    it 'verifies that answer has different body length depending on a type' do
      answer.should allow_value('Not too long for an answer').for(:body)
    end

  end

  describe 'Associations' do
    it { should belong_to(:question) }
    it { should have_many(:votes) }
  end

  describe 'Methods' do
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
