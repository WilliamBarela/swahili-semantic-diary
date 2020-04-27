class Word < ApplicationRecord
  has_many :glosses
  has_many :stories, through: :glosses

  accepts_nested_attributes_for :glosses

  # FIXME: this is not right
  # def gloss_attributes=(gloss_attributes)
  #   # raise gloss_attributes.inspect
  #   gloss_attributes.values.each do |gloss_attribute|
  #     gloss = Gloss.find_or_create_by(gloss_attribute)
  #     self.glosses.build(gloss: gloss)
  #   end
  # end
end
