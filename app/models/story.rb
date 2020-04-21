class Story < ApplicationRecord
  belongs_to :author
  
  validates :story_title, :story,
    presence: true

  validates :story_title,
    uniqueness: true
end
