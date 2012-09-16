module Jqame
  class Vote < ActiveRecord::Base

    # Associations
    belongs_to :votable, polymorphic: true
    belongs_to :employee

    attr_accessible :votable, :upvote

    # Scopes
    scope :on, -> votable { where(votable_id: votable.id, votable_type: votable.class.model_name) }

    # Validations
    validates :employee_id, uniqueness: { scope: [ :votable_id, :votable_type, :upvote ] }

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
