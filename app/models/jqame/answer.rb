module Jqame
  class Answer < ActiveRecord::Base
    attr_accessible :body, :full

    belongs_to :question

    validates :body, presence: true
  end
end
