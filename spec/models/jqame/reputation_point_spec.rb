require 'spec_helper'

describe Jqame::ReputationPoint do

  describe 'Validations' do
    it { should belong_to(:vote) }
    it { should belong_to(:elector) }
    it { should belong_to(:question) }
  end

end
