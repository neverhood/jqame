require_dependency "jqame/application_controller"

module Jqame
  class CommentsController < ApplicationController
    respond_to :html

    before_filter :authenticate_elector!, only: [ :create, :destroy, :update, :edit ]
    before_filter :find_votable!, only: [ :create, :edit ]
    before_filter :find_comment!, only: [ :destroy, :edit, :update ]
    before_filter :require_comment_owner!, only: [ :destroy, :edit, :update ]

    def create
      @comment = @votable.comment_with(params[:comment], elector)
      respond_with @comment, location: jqame.question_path(@comment.question)
    end

    def destroy
      @comment.destroy
      respond_with @comment, location: jqame.question_path(@comment.question)
    end

    def edit
    end

    def update
      @comment.update_attributes(body: params[:comment])
    end

    private

    def find_votable!
      if @votable = Jqame::Votable.find(params[:comment])
        params[:comment].reject! { |key, value| not Jqame::Comment.accessible_attributes.include?(key) }
      else
        render_not_found
      end
    end

    def find_comment!
      @comment = Jqame::Comment.where(id: params[:id]).first
      render_not_found if @comment.nil?
    end

    def require_comment_owner!
      render_permission_denied unless current_elector.owns_suffrage?(@comment)
    end
  end
end
