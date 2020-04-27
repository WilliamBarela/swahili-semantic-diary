class Word < ApplicationRecord
  has_many :glosses
  has_many :stories, through: :glosses
end
