module Jqame::Votable

  mattr_accessor :votable_mappings, :votable_classes, :votable_classes_idioms

  @@votable_classes = [ 'Jqame::Question', 'Jqame::Answer' ]
  @@votable_classes_idioms = %w( question answer )
  @@votable_mappings = { question: Jqame::Question, answer: Jqame::Answer }

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

  def upvoted!
    increment!(:current_rating, 1)
  end

  def downvoted!
    increment!(:current_rating, -1)
  end

  def vote_destroyed! vote
    increment!(:current_rating, ( vote.upvote ? -1 : 1 ))
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
