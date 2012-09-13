module Jqame
  class Answer < ActiveRecord::Base
    attr_accessible :body, :full

    belongs_to :question
    has_many   :votes, :dependent => :destroy, :as => :votable

    MAX_ANSWER_LENGTH = 10000
    MAX_COMMENT_LENGTH = 200

    validates :body, length: { within: (1..MAX_ANSWER_LENGTH) }, if: 'answer?'
    validates :body, length: { within: (1..MAX_COMMENT_LENGTH) }, if: 'comment?'

    def comment?
      not full?
    end

    def answer?
      full?
    end

  end
end
