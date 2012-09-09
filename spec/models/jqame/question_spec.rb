require 'spec_helper'

describe Jqame::Question do

  describe 'Validations' do
    subject { FactoryGirl.build(:question) }

    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

end
