# This migration comes from jqame (originally 20121102174057)
class CreateJqameReputationPoints < ActiveRecord::Migration
  def change
    create_table :jqame_reputation_points do |t|
      t.integer :elector_id
      t.integer :question_id
      t.integer :vote_id
      t.integer :reputation_amount
      t.integer :action

      t.timestamps
    end
  end
end
