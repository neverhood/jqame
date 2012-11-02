require 'spec_helper'

describe Jqame::QuestionsController do
  include Devise::TestHelpers

  let(:elector) { FactoryGirl.create(:elector) }
  let(:question) { FactoryGirl.create(:jqame_question) }

  describe '#find_question! before filter' do
    describe 'Given a valid question id' do
      before do
        get :show, { id: question.id, use_route: 'jqame' }
      end

      it { should assign_to(:question) }
      it { should respond_with(:success) }
      it { should render_template(:show) }
    end

    describe 'Given an invalid question id' do
      it 'should render 404' do
        lambda { get(:show, { id: 100500, use_route: 'jqame' }) }.should raise_error
      end
    end
  end

  context 'Not signed in' do
    describe 'Edit' do
      before { get :edit, { id: question, use_route: 'jqame' } }

      it { should respond_with(:redirect) }
    end
  end

  context 'Stateless' do
    describe 'Index' do
      before { get :index, { use_route: 'jqame' } }

      it { should assign_to(:questions) }
      it { should respond_with(:success) }
      it { should render_template(:index) }
    end
  end

end
