class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.string :story_title
      t.text :story
      t.references :author, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
