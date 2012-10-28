module Jqame
  class QuestionView < ActiveRecord::Base

    belongs_to :elector, class_name: Jqame.elector_class
    belongs_to :question, class_name: 'Jqame::Question'

    def self.store!(question, elector)
      return nil if exists?(question, elector) or elector.id == question.elector_id

      create question_id: question.id, elector_id: elector.id
    end

    def self.exists?(question, elector)
      where(question_id: question.id, elector_id: elector.id).any?
    end

  end
end
