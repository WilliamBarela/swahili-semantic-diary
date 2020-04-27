class Story < ApplicationRecord
  belongs_to :author

  has_many :glosses
  has_many :lemmas, through: :glosses
  
  validates :story_title, :story,
    presence: true

  validates :story_title,
    uniqueness: true

  validate :valid_title_length?

  validate :valid_story_length?

  def valid_title_length?
    errors.add(:story_title, "is currently #{self.story_title.length} characters long. It must be between 3 and 60 characters") unless self.story_title.nil? or self.story_title.length.between?(3,60)
  end

  def valid_story_length?
    errors.add(:story, "is currently #{self.story_word_length} words long. It must be between 5 and 500 words.") unless self.story.nil? or self.story_word_length.between?(5,500)
  end

  def story_word_length
    self.story.split(" ").length
  end
end
