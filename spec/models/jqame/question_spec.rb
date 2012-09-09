require 'spec_helper'

describe Jqame::Question do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:title) }
end
