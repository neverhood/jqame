require_dependency "jqame/application_controller"

module Jqame
  class CommentsController < ApplicationController
    respond_to :html

    before_filter :authenticate_elector!, only: [ :create, :destroy, :update, :edit ]
    before_filter :find_votable!, only: [ :create, :edit ]
    before_filter :find_comment!, only: [ :destroy, :edit, :update ]
    before_filter :require_comment_owner!, only: [ :destroy, :edit, :update ]

    def create
      @comment = @votable.comment_with(current_elector, comment_params)
      respond_with @comment, location: jqame.question_path(@comment.question)
    end

    def destroy
      @comment.destroy
      respond_with @comment, location: jqame.question_path(@comment.question)
    end

    def edit
    end

    def update
      @comment.update_attributes(params[:comment].permit(:body))
    end

    private

    def find_votable!
      @votable = Jqame::Votable.find(params[:comment])
      render_not_found if @votable.nil?
    end

    def find_comment!
      @comment = Jqame::Comment.where(id: params[:id]).first
      render_not_found if @comment.nil?
    end

    def require_comment_owner!
      render_permission_denied unless current_elector.owns_suffrage?(@comment)
    end

    def comment_params
      action_name.inquiry.create?? params[:comment].permit(:body, :votable) : params[:comment].permit(:body)
    end
  end
end
