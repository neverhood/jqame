require 'spec_helper'

describe Jqame::Question do

  describe 'Validations' do
    subject { FactoryGirl.build(:question) }

    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe 'Associations' do
    it { should have_many(:answers) }
  end

  describe 'Methods' do
    describe '#answer_with' do
      it 'should save and return an answer if valid params were given' do
      end

      it 'should return an answer with #errors if invalid params were given' do
      end
    end
  end

end
