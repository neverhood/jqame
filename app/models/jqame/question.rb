module Jqame
  class Question < ActiveRecord::Base
    attr_accessible :body, :current_rating, :title

    validates :body, :title, presence: true
    validates :title, uniqueness: { case_sensitive: false }
  end
end
