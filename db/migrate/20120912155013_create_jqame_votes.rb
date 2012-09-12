class CreateJqameVotes < ActiveRecord::Migration
  def change
    create_table :jqame_votes do |t|
      t.integer :employee_id
      t.references :votable, polymorphic: true

      t.timestamps
    end
  end
end
