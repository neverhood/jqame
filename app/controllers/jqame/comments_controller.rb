require_dependency "jqame/application_controller"

module Jqame
  class CommentsController < ApplicationController
    respond_to :html

    before_filter :authenticate_elector!, only: [ :destroy ]
    before_filter :find_comment!, only: [ :destroy ]
    before_filter :require_comment_owner!, only: [ :destroy ]

    def destroy
      @comment.destroy
      respond_with @comment, location: jqame.question_path(@comment.question)
    end

    private

    def find_comment!
      @comment = Jqame::Comment.where(id: params[:id]).first
      render_not_found if @comment.nil?
    end

    def require_comment_owner!
      render_permission_denied unless current_elector.owns_suffrage?(@comment)
    end

  end
end
