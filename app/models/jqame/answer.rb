module Jqame
  class Answer < ActiveRecord::Base
    include Jqame::Votable

    @votable_type       = :answer
    attr_accessible :body, :full

    belongs_to :question

    validates :body, length: { within: (1..50000) }
  end
end
