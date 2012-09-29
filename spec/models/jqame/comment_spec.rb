require 'spec_helper'

describe Jqame::Comment do

  describe 'Associations' do
    let(:comment) { FactoryGirl.create(:jqame_comment) }
    let(:answer_comment) { FactoryGirl.create(:jqame_comment_on_answer) }

    it { should belong_to :votable }
    it { should belong_to :employee }

    describe 'Votable' do
      specify { comment.votable.should be_an_instance_of(Jqame::Question) }
      specify { answer_comment.votable.should be_an_instance_of(Jqame::Answer) }
    end
  end

  describe 'Validations' do
    it { should ensure_length_of(:body).is_at_least(1).is_at_most(1000) }
  end

end