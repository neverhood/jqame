module Jqame
  class Comment < ActiveRecord::Base
    attr_accessible :body, :votable

    belongs_to :votable, polymorphic: true
    belongs_to :elector, class_name: Jqame.elector_class

    validates :body, length: { within: (1..1000) }

    def votable= votable
      tap do |vote|
        vote.votable_id = votable.id
        vote.votable_type = votable.class.model_name
      end
    end
  end
end
