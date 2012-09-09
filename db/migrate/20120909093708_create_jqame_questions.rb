class CreateJqameQuestions < ActiveRecord::Migration
  def change
    create_table :jqame_questions do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
