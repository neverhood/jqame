module Jqame
  class Question < ActiveRecord::Base
    attr_accessible :body, :title

    validates :body, :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }

    has_many :answers, :dependent => :destroy
    has_many :votes, :dependent => :destroy, :as => :votable

    # builds and attempts to save an answer
    def answer_with options
      answers.new(options).tap { |answer| answer.save }
    end
  end
end
