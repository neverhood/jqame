module Jqame
  class Answer < ActiveRecord::Base
    include Jqame::Votable

    def self.votable_type
      :answer
    end

    belongs_to :question
    has_many :comments, :dependent => :destroy, :as => :votable
    has_many :votes, :dependent => :destroy, :as => :votable
    belongs_to :elector, class_name: Jqame.elector_class

    scope :top, -> count = 5 { limit(count).order("'jqame_answers'.'current_rating' DESC") }

    validates :body, length: { within: (1..50000) }

    def accept!
      return false if accepted?

      update_attributes(accepted: true)
    end

    def unaccept!
      return false unless accepted?

      update_attributes(accepted: false)
    end

  end
end
