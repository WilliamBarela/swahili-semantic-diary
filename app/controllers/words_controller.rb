class WordsController < ApplicationController
  def new
    @word = Word.new
    @story_word_glosses = current_story.word_glosses
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      redirect_to author_stories_path(current_author)
    else
      # FIXME render :new
      raise "word not saved :(".inspect
    end
  end

  private
    def word_params
      params.require(:word).permit(:lemma, :lexical_category, :lemma_class, :notes, :origin, glosses_attributes: [:gloss, :story_id])
    end
end
