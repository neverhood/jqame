module Jqame
  class Question < ActiveRecord::Base
    include Jqame::Votable

    @votable_type = :question
    attr_accessible :body, :title

    validates :body, :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }
    validates :body, length: { within: (1..50000) }

    has_many :answers, :dependent => :destroy

    # builds and attempts to save an answer
    def answer_with options
      answers.new(options).tap { |answer| answer.save }
    end

  end
end
