class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :lemma
      t.string :lexical_category
      t.string :class
      t.string :notes
      t.string :origin

      t.timestamps
    end
  end
end
