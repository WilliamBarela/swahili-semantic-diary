class WordsController < ApplicationController
  def new
    @word = current_story.words.build
  end

  def create
    @word = current_story.words.build(word_params)
    if @word.save
      redirect_to author_stories_path(current_author)
    else
      raise "word not saved :(".inspect
    end
  end

  private
    def word_params
      params.require(:word).permit(:lemma, :lexical_category, :lemma_class, :notes, :origin, glosses_attributes: [:gloss])
    end
end
