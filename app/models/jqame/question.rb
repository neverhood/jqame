module Jqame
  class Question < ActiveRecord::Base
    include Jqame::Votable

    def self.votable_type
      :question
    end

    validates :body, :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }
    validates :body, length: { within: (1..50000) }

    has_many :answers, :dependent => :destroy
    has_many :comments, :dependent => :destroy, :as => :votable
    has_many :votes, :dependent => :destroy, :as => :votable
    has_many :question_views, :dependent => :destroy
    has_many :reputation_points, :dependent => :destroy
    belongs_to :elector, class_name: Jqame.elector_class

    paginates_per 50

    default_scope -> { order("'jqame_questions'.'created_at' DESC") }

    scope :top, -> count = 5 { limit(count).order("'jqame_questions'.'current_rating' DESC") }
    scope :recent, -> count = 25 { limit(count).order("'jqame_questions'.'created_at' DESC") }

    # builds and attempts to save an answer
    def answer_with elector, options
      answers.new(options.merge({ elector_id: elector.id })).tap { |answer| answer.save }
    end

    def has_accepted_answer?
      answers.where(accepted: true).any?
    end

    def accepted_answer
      answers.where(accepted: true).first
    end

    def times_favorited
      Jqame::FavoritedQuestion.where(question_id: id).count
    end

  end
end
