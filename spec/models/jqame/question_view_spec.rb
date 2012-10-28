require 'spec_helper'

describe Jqame::QuestionView do

  let(:question) { FactoryGirl.create(:jqame_question) }
  let(:elector) { FactoryGirl.create(:elector) }

  context 'With existing record' do
    before do
      @question_view = Jqame::QuestionView.store!(question, elector)
    end

    it 'sfasf' do
      @question_view.should be_persisted
    end

    it 'won`t store duplicated record' do
      Jqame::QuestionView.store!(question, elector).should be_nil
    end
  end

  it 'won`t store question view for question owner' do
    Jqame::QuestionView.store!(question, question.elector).should be_nil
  end

end
