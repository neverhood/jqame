require_dependency "jqame/application_controller"

module Jqame
  class QuestionsController < ApplicationController

    respond_to :html, :json
    before_filter :find_question!, only: [ :show, :edit, :update, :destroy ]
    before_filter :"authenticate_#{Jqame.elector_string}!", only: [ :new, :create, :update, :edit, :destroy ]

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
    end

    def edit
    end

    def destroy
    end

  end
end
