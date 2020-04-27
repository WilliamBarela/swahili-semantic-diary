class CreateGlosses < ActiveRecord::Migration[6.0]
  def change
    create_table :glosses do |t|
      t.string :gloss
      t.belongs_to :word, index: true, null: false, foreign_key: true
      t.belongs_to :story, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
