require_dependency "jqame/application_controller"

module Jqame
  class AnswersController < ApplicationController

    respond_to :html

    before_filter :find_answer!,            only: [ :edit, :update, :destroy, :accept, :unaccept ]
    before_filter :authenticate_elector!,   only: [ :create, :destroy, :update, :edit, :accept, :unaccept ]
    before_filter :require_answer_owner!,   only: [ :destroy, :edit, :update ]
    before_filter(only: [ :accept, :unaccept ]) { |controller| controller.require_question_owner!(@question = @answer.question) }

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

    def accept
      current_elector.accept! @question, @answer
      respond_with @question
    end

    def unaccept
      current_elector.unaccept! @question, @answer
      respond_with @question
    end

    private

    def answer_params
      params.require(:answer).permit(:body)
    end

  end
end
