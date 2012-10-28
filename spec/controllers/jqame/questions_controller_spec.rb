require 'spec_helper'

describe Jqame::QuestionsController do
  include Devise::TestHelpers

  describe '#find_question! before filter' do
    describe 'Given a valid question id' do
      before do
        @question = FactoryGirl.create(:jqame_question)
        get :show, { id: @question.id, use_route: 'jqame' }
      end

      it { should assign_to(:question) }
      it { should respond_with(:success) }
      it { should render_template(:show) }
    end

    describe 'Given an invalid question id' do
      it 'should render 404' do
        lambda { get(:show, { id: rand(50), use_route: 'jqame' }) }.should raise_error
      end
    end
  end

end
