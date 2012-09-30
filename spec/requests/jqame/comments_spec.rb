require 'spec_helper'

describe 'Comments' do
  include VotableSpecHelper
  include ElectorAuthentication

  let(:elector) { FactoryGirl.create(:elector) }
  let(:votable) { FactoryGirl.create(:jqame_question, elector: elector) }
  let(:comment) { FactoryGirl.create(:jqame_comment, votable: votable, elector: elector) }

  before { sign_in elector }

  context 'With persisted comment' do
    before { comment.save }

    it 'should destroy comment' do
      visit jqame.question_path(comment.question)

      within "div#comment-#{comment.id}" do
        click_link I18n.t('jqame.comments.comment.destroy')
      end

      current_path.should == jqame.question_path(comment.question)
      page.should_not have_content(comment.body)
    end
  end

  context 'With unpersisted comment' do
    context 'Elector signed in' do
      it 'should create a new comment' do
        visit jqame.question_path(comment.question)

        within 'form#new-comment' do
          fill_in 'comment_body',         with: comment.body
          find('input#comment_votable_id').set comment.votable_id
          find('input#comment_votable_type').set comment.votable_type

          click_button I18n.t('jqame.comments.form.submit')
        end

        current_path.should == jqame.question_path(comment.question)
        page.should have_content(comment.body)
      end
    end
  end
end

