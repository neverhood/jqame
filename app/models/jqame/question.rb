module Jqame
  class Question < ActiveRecord::Base
    attr_accessible :body, :title
  end
end
