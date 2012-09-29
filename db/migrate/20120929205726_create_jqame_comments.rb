class CreateJqameComments < ActiveRecord::Migration
  def change
    create_table :jqame_comments do |t|
      t.integer :elector_id
      t.text :body
      t.references :votable, polymorphic: true

      t.timestamps
    end
  end
end
