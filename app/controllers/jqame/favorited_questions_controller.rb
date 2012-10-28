require_dependency "jqame/application_controller"

module Jqame
  class FavoritedQuestionsController < ApplicationController

    respond_to :html, :json

    before_filter :authenticate_elector!
    before_filter :find_favorited_question!, only: [ :destroy ]
    before_filter :find_question!, only: [ :create ]

    def create
      current_elector.add_to_favorites! @question

      respond_with @question
    end

    def index
      @favorited_questions = current_elector.favorited_questions
    end

    def destroy
      @favorited_question.destroy

      respond_with @favorited_question.question
    end

    private

    def find_favorited_question!
      @favorited_question = Jqame::FavoritedQuestion.where(id: params.require(:id)).first
    end

    def require_favorited_question_owner!
      render_permission_denied unless @favorited_question.elector_id == current_elector.id
    end

  end
end
