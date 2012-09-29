module Jqame::Votable

  def comment_with options
    comments.new(options).tap { |comment| comment.save }
  end

  def self.included(base)
    base.has_many :comments, :dependent => :destroy, :as => :votable
    base.has_many :votes, :dependent => :destroy, :as => :votable
    base.belongs_to :elector, class_name: Jqame.elector_class

    base.scope :top, -> count = 5 { base.limit(count).order("'#{base.table_name}'.current_rating DESC") }

    class << base
      attr_accessor :votable_type
    end
  end

  module ClassMethods
  end

end
