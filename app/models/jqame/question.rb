module Jqame
  class Question < ActiveRecord::Base
    include Jqame::Votable

    @votable_type = :question
    attr_accessible :body, :title

    validates :body, :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }
    validates :body, length: { within: (1..50000) }

    has_many :answers, :dependent => :destroy
    has_many :comments, :dependent => :destroy, :as => :votable
    has_many :votes, :dependent => :destroy, :as => :votable
    belongs_to :elector, class_name: Jqame.elector_class

    scope :top, -> count = 5 { limit(count).order("'jqame_questions'.'current_rating' DESC") }

    # builds and attempts to save an answer
    def answer_with options, elector
      answers.new(options).tap do |answer|
        answer.elector_id = elector.id
        answer.save
      end
    end

  end
end
