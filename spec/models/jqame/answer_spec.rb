require 'spec_helper'

describe Jqame::Answer do

  describe 'Validations' do
    it { should validate_presence_of(:body) }
  end

  describe 'Associations' do
    it { should belong_to(:question) }
    it { should have_many(:votes) }
  end

end
