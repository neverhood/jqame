require_dependency "jqame/application_controller"

module Jqame
  class AnswersController < ApplicationController

    respond_to :html

    before_filter :find_answer!,          only: [ :edit, :update, :destroy ]
    before_filter :authenticate_elector!, only: [ :create, :destroy, :update, :edit ]
    before_filter :require_answer_owner!, only: [ :destroy, :edit, :update ]

    def edit
    end

    def destroy
      @answer.destroy
      respond_with @answer.question
    end

    def update
      @question = @answer.question
      @answer.update_attributes(answer_params)

      if @answer.valid?
        redirect_to jqame.question_path(@question)
      else
        respond_with @answer, location: jqame.edit_answer_path(@answer)
      end
    end

    private

    def require_answer_owner!
      render_permission_denied unless current_elector.owns_suffrage?(@answer)
    end

    def answer_params
      params.require(:answer).permit(:body)
    end

  end
end
