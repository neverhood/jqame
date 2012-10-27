require_dependency "jqame/application_controller"

module Jqame
  class VotablesController < ApplicationController

    respond_to :html, :json

    before_filter :authenticate_elector!
    before_filter :find_votable!

    def upvote
      current_elector.upvote! @votable

      respond_to do |format|
        format.html { redirect_to @votable.question?? @votable : @votable.question }
        format.json { render json: @votable }
      end
    end

    def downvote
      current_elector.downvote! @votable

      respond_to do |format|
        format.html { redirect_to @votable.question?? @votable : @votable.question }
        format.json { render json: @votable }
      end
    end

    def comment
      @comment = @votable.comment_with current_elector, comment_params

      respond_to do |format|
        format.html { redirect_to @comment.question }
        format.json { render json: @comment }
      end
    end

    private

    def find_votable!
      parameters = action_name == 'comment' ? comment_params : vote_params
      @votable = Jqame::Votable.find(parameters)

      render_not_found if @votable.nil?
    end

    def comment_params
      params.require(:comment).permit(:body, :votable_id, :votable_type)
    end

    def vote_params
      params.permit(:votable_id, :votable_type)
    end

  end
end
