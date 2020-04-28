class Word < ApplicationRecord
  has_many :glosses
  has_many :stories, through: :glosses, dependent: :destroy

  # accepts_nested_attributes_for :glosses

  validates :lemma,
    presence: true


  def glosses_attributes=(glosses_attributes)
    glosses_attributes.each do |gloss_attribute|
      word_id = self.id
      gloss = gloss_attribute[1][:gloss]
      story_id = gloss_attribute[1][:story_id]

      gloss = Gloss.find_or_create_by(:gloss => gloss, :story_id => story_id, :word_id => word_id)
      self.glosses << gloss
    end
  end

  def self.find_or_create_lemma(word_params)
    Word.find_or_create_by(:lemma => word_params[:lemma],
                           :lexical_category => word_params[:lexical_category],
                           :lemma_class => word_params[:lemma_class])
  end
end
