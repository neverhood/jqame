require 'spec_helper'

describe Jqame::FavoritedQuestion do

  describe 'Associations' do
    it { should belong_to(:question) }
    it { should belong_to(:elector)  }
  end

end
