module Jqame
  class Answer < ActiveRecord::Base
    class << self
      attr_accessor :max_answer_length, :max_comment_length
    end

    @max_answer_length  = 10000
    @max_comment_length = 200

    attr_accessible :body, :full

    belongs_to :question
    belongs_to :employee
    has_many   :votes, :dependent => :destroy, :as => :votable

    validates :body, length: { within: (1..@max_answer_length) }, if: 'answer?'
    validates :body, length: { within: (1..@max_comment_length) }, if: 'comment?'

    def comment?
      not full?
    end

    def answer?
      full?
    end

  end
end
