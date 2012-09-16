module Jqame
  class Vote < ActiveRecord::Base
    class << self
      attr_accessor :rates
    end

    # Amount of reputation to be granted/withdrawn for an employee upon upvote/downvote of his question or answer
    @rates = { question: 10, answer: 5 }

    # Associations
    belongs_to :votable, polymorphic: true
    belongs_to :employee

    attr_accessible :votable, :upvote

    # Scopes
    scope :on, -> votable { where(votable_id: votable.id, votable_type: votable.class.model_name) }

    # Validations
    validates :employee_id, uniqueness: { scope: [ :votable_id, :votable_type, :upvote ] }

    # Callbacks
    before_save    :update_votable_rating_after_create
    before_destroy :update_votable_rating_after_destroy

    def votable= votable
      tap do |vote|
        vote.votable_id = votable.id
        vote.votable_type = votable.class.model_name
      end
    end

    def downvote?
      not upvote?
    end

    private

    def update_votable_rating_after_create
      votable.increment!(:current_rating, ( upvote?? 1 : -1 ))
    end

    def update_votable_rating_after_destroy
      votable.increment!(:current_rating, ( upvote?? -1 : 1 ))
    end

  end
end
