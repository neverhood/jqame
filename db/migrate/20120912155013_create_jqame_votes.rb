class CreateJqameVotes < ActiveRecord::Migration
  def change
    create_table :jqame_votes do |t|
      t.integer :elector_id
      t.boolean :upvote, default: true
      t.references :votable, polymorphic: true

      t.timestamps
    end
  end
end
