class CreateJqameQuestionViews < ActiveRecord::Migration
  def change
    create_table :jqame_question_views do |t|
      t.integer :question_id
      t.integer :elector_id

      t.timestamps
    end

    add_index :jqame_question_views, [ :question_id, :elector_id ], unique: true
  end
end
