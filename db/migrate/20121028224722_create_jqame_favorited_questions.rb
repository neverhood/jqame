class CreateJqameFavoritedQuestions < ActiveRecord::Migration
  def change
    create_table :jqame_favorited_questions do |t|
      t.integer :question_id
      t.integer :elector_id
    end

    add_index :jqame_favorited_questions, [ :question_id, :elector_id ], unique: true
  end
end
