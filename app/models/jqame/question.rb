module Jqame
  class Question < ActiveRecord::Base

    class << self
      attr_accessor :votable_type
    end
    @votable_type = :question

    attr_accessible :body, :title

    validates :body, :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }

    belongs_to :employee
    has_many :answers, :dependent => :destroy
    has_many :votes, :dependent => :destroy, :as => :votable

    scope :top, -> count = 5 { limit(count).order('jqame_questions.current_rating DESC') }

    # builds and attempts to save an answer
    def answer_with options
      answers.new(options).tap { |answer| answer.save }
    end

  end
end
