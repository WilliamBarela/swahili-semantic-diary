class Story < ApplicationRecord
  belongs_to :author
  
  validates :story_title, :story,
    presence: true
end
