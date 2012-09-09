# This migration comes from jqame (originally 20120909132145)
class CreateJqameQuestions < ActiveRecord::Migration
  def change
    create_table :jqame_questions do |t|
      t.string :title
      t.text :body
      t.integer :current_rating

      t.timestamps
    end
  end
end
