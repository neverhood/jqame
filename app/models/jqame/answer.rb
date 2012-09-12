module Jqame
  class Answer < ActiveRecord::Base
    attr_accessible :body, :full

    belongs_to :question
    has_many   :votes, :dependent => :destroy, :as => :votable

    validates :body, presence: true
  end
end
