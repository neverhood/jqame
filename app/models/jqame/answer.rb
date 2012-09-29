module Jqame
  class Answer < ActiveRecord::Base
    include Jqame::Votable

    @votable_type       = :answer
    attr_accessible :body, :full

    belongs_to :question
    belongs_to :elector, class_name: Jqame.elector_class

    validates :body, length: { within: (1..50000) }

    scope :top, -> count = 5 { limit(count).order('jqame_answers.current_rating DESC') }
  end
end
