class WordsController < ApplicationController
  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
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
      params.require(:word).permit(:lemma, :lexical_category, :lemma_class, :notes, :origin, glosses_attributes: [:gloss, :story_id])
    end
end
