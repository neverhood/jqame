module Jqame::Votable

  mattr_accessor :votables
  @@votables = [ Jqame::Question, Jqame::Answer ]

  def self.find(options)
    return nil unless options[:votable_type].present? and options[:votable_id].present? and votable?(options[:votable_type])

    options[:votable_type].constantize.where(id: options[:votable_id]).first
  end

  def comment_with elector, options
    comments.new({ body: options[:body], elector_id: elector.id }).tap { |comment| comment.save }
  end

  def question?
    self.is_a? Jqame::Question
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
