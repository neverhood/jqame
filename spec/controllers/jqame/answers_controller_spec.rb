require 'spec_helper'

describe Jqame::AnswersController do
  include Devise::TestHelpers

  let(:elector) { FactoryGirl.create(:elector) }
  let(:answer) { FactoryGirl.create(:jqame_answer, elector: elector) }

  context 'Signed in' do
    before { sign_in elector }

    describe 'Edit' do
      before { get :edit, { id: answer, use_route: 'jqame' } }

      it { should assign_to(:answer) }
      it { should respond_with(:success) }
      it { should render_template(:edit) }
    end
  end

  context 'Not signed in' do
    describe 'Edit' do
      before { get :edit, { id: answer, use_route: 'jqame' } }

      it { should respond_with(:redirect) }
    end
  end

end
