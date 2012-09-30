require_dependency "jqame/application_controller"

module Jqame
  class QuestionsController < ApplicationController

    respond_to :html

    before_filter :find_question!, only: [ :show, :edit, :update, :destroy ]
    before_filter :authenticate_elector!, only: [ :new, :create, :update, :edit, :destroy ]
    before_filter :require_question_owner!, only: [ :update, :edit, :destroy ]

    def index
      @questions = Question.all
    end

    def show
    end

    def new
      @question = Question.new
    end

    def create
      @question = Question.create(params[:question])
      respond_with @question
    end

    def update
      @question.update_attributes(params[:question])
      respond_with @question
    end

    def edit
    end

    def destroy
      @question.destroy
      respond_with @question
    end

    private

    def require_question_owner!
      render_permission_denied unless current_elector.owns_votable?(@question)
    end

  end
end
