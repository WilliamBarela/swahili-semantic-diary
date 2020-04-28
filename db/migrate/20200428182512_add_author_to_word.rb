class AddAuthorToWord < ActiveRecord::Migration[6.0]
  def change
    add_reference :words, :author, index: true, null: false, foreign_key: true
  end
end
