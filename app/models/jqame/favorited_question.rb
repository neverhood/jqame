module Jqame
  class FavoritedQuestion < ActiveRecord::Base

    belongs_to :elector, class_name: Jqame.elector_class
    belongs_to :question

  end
end
