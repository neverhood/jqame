module Jqame::Votable

  mattr_accessor :votables_mappings, :votable_classes, :votable_classes_idioms

  @@votable_classes = [ 'Jqame::Question', 'Jqame::Answer' ]
  @@votable_classes_idioms = %w( question answer )
  @@votables_mappings = { question: Jqame::Question, answer: Jqame::Answer }

  def self.find(options)
    return nil unless options[:votable_type].present? and options[:votable_id].present?

    klass = votable_class(options[:votable_type])
    return nil if klass.nil?

    klass.where(id: options[:votable_id]).first
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

  def self.votable_class(klass)
    if votable_classes.include? klass
      klass.constantize
    elsif votable_classes_idioms.include? klass
      votable_mappings[ klass.to_sym ]
    end
  end

end
