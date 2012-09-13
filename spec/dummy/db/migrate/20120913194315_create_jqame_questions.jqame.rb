# This migration comes from jqame (originally 20120909132145)
class CreateJqameQuestions < ActiveRecord::Migration
  def change
    create_table :jqame_questions do |t|
      t.string :title
      t.text :body
      t.integer :current_rating, default: 0, limit: 2

      t.timestamps
    end

    add_index :jqame_questions, :title, unique: true
  end
end
