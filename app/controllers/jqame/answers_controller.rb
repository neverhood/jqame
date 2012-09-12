require_dependency "jqame/application_controller"

module Jqame
  class AnswersController < ApplicationController

    before_filter :find_answer!, only: [ :edit, :update, :destroy ]

    def new
    end

    def create
    end

    def destroy
    end

    def update
    end

    def edit
    end

  end
end
