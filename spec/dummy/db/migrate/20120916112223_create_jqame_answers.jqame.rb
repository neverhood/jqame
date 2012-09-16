# This migration comes from jqame (originally 20120909211921)
class CreateJqameAnswers < ActiveRecord::Migration
  def change
    create_table :jqame_answers do |t|
      t.text :body
      t.boolean :full, default: true
      t.integer :current_rating, default: 0, limit: 2
      t.integer :question_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
