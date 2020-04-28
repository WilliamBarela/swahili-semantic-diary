class WordsController < ApplicationController
  def new
    @word = Word.new
  end

  def create
    if (@word = Word.find_or_create_lemma(word_params)) && @word.update(word_params)
      redirect_to new_story_word_path(current_story)
    else
      render :new
    end
  end

  def destroy
    Word.find_by_id!(params[:id]).destroy
    redirect_to new_story_word_path(current_story)
  end

  private
    def word_params
      params.require(:word).permit(:lemma, :lexical_category, :lemma_class, :notes, :origin, :author_id, glosses_attributes: [:gloss, :story_id])
    end
end
