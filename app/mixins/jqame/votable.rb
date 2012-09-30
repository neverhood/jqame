module Jqame::Votable

  mattr_accessor :votables
  @@votables = [ Jqame::Question, Jqame::Answer ]

  def self.find(options)
    return nil unless options[:votable_type].present? and options[:votable_id].present? and votable?(options[:votable_type])

    options[:votable_type].constantize.where(id: options[:votable_id]).first
  end

  def comment_with options, elector
    comments.new(body: options[:body]).tap do |comment|
      comment.elector_id = elector.id
      comment.save
    end
  end

  def self.included(base)
    class << base
      attr_accessor :votable_type
    end
  end

  module ClassMethods
  end

  private

  def self.votable?(klass)
    if klass.is_a? String
      votables.map(&:to_s).include?(klass)
    else
      votables.include?(klass)
    end
  end

end
