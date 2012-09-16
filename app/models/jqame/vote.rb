module Jqame
  class Vote < ActiveRecord::Base

    belongs_to :votable, polymorphic: true
    belongs_to :employee

    attr_accessible :votable, :upvote

    scope :on, -> votable { where(votable_id: votable.id, votable_type: votable.class.model_name) }

    def votable= votable
      tap do |vote|
        vote.votable_id = votable.id
        vote.votable_type = votable.class.model_name
      end
    end

    def downvote?
      not upvote?
    end

  end
end
