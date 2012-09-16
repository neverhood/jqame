module Jqame
  class Vote < ActiveRecord::Base
    class << self
      attr_accessor :rates
    end

    # Amount of reputation to be granted/withdrawn for an employee upon upvote/downvote of his question or answer
    @rates = {
      question: { upvote: 10, downvote: -5 },
      answer:   { upvote:  5, downvote: -3 }
    }

    # Associations
    belongs_to :votable, polymorphic: true
    belongs_to :employee

    attr_accessible :votable, :upvote

    # Scopes
    scope :on, -> votable { where(votable_id: votable.id, votable_type: votable.class.model_name) }

    # Validations
    validates :employee_id, uniqueness: { scope: [ :votable_id, :votable_type, :upvote ] }

    # Callbacks
    # Votable
    before_create  :update_votable_rating_before_create
    before_destroy :update_votable_rating_before_destroy
    # Employee
    before_create  :update_employee_reputation_before_create
    before_destroy :update_employee_reputation_before_destroy

    def votable= votable
      tap do |vote|
        vote.votable_id = votable.id
        vote.votable_type = votable.class.model_name
      end
    end

    def downvote?
      not upvote?
    end

    def kind
      upvote?? :upvote : :downvote
    end

    private

    def update_votable_rating_before_create
      votable.increment!(:current_rating, ( upvote?? 1 : -1 ))
    end

    def update_votable_rating_before_destroy
      votable.increment!(:current_rating, ( upvote?? -1 : 1 ))
    end

    def update_employee_reputation_before_create
      modifier = Vote.rates[votable.class.votable_type][kind]

      votable.employee.increment!(:reputation, modifier)
    end

    def update_employee_reputation_before_destroy
      modifier = Vote.rates[votable.class.votable_type][kind]

      votable.employee.increment!(:reputation, - modifier)
    end

  end
end
