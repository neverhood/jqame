require_dependency "jqame/application_controller"

module Jqame
  class AnswersController < ApplicationController

    respond_to :html

    before_filter :find_question!, only: [ :create, :edit ]
    before_filter :find_answer!, only: [ :edit, :update, :destroy ]
    before_filter :authenticate_elector!, only: [ :create, :destroy, :update, :edit ]
    before_filter :require_answer_owner!, only: [ :destroy, :edit, :update ]

    def create
      @answer = @question.answer_with(params[:answer], current_elector)
      respond_with [ @question, @answer ], location: jqame.question_path(@question)
    end

    def destroy
      @answer.destroy
      respond_with @answer, location: jqame.question_path(id: @answer.question_id)
    end

    def update
      @question = @answer.question
      @answer.update_attributes(params[:answer])

      respond_with [@question, @answer], location: jqame.edit_question_answer_path(@question, @answer)
    end

    def edit
    end

    private

    def require_answer_owner!
      render_permission_denied unless current_elector.owns_suffrage?(@answer)
    end

  end
end
