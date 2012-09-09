module Jqame
  class Question < ActiveRecord::Base
    attr_accessible :body, :title

    validates :body, :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }

    has_many :answers
  end
end
