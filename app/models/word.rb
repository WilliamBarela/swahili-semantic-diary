class Word < ApplicationRecord
  has_many :glosses
  has_many :stories, through: :glosses, dependent: :destroy

  accepts_nested_attributes_for :glosses

  validates :lemma,
    presence: true


  # FIXME: this is not right
  # def gloss_attributes=(gloss_attributes)
  #   # raise gloss_attributes.inspect
  #   gloss_attributes.values.each do |gloss_attribute|
  #     gloss = Gloss.find_or_create_by(gloss_attribute)
  #     self.glosses.build(gloss: gloss)
  #   end
  # end

  def self.find_or_create_lemma(word_params)
    Word.find_or_create_by(:lemma => word_params[:lemma],
                           :lexical_category => word_params[:lexical_category],
                           :lemma_class => word_params[:lemma_class])
  end
end
