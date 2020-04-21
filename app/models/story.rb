class Story < ApplicationRecord
  belongs_to :author
  
  validates :story_title, :story,
    presence: true

  validates :story_title,
    uniqueness: true

  validate :valid_title_length?

  def valid_title_length?
    errors.add(:story_title, "is currently #{self.story_title.length} characters long. It must be between 3 and 60 characters") unless self.story_title.nil? or self.story_title.length.between?(3,60)
  end
end
