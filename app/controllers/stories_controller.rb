class StoriesController < ApplicationController
  before_action :authenticate_author!

  def index
    @author = current_author
  end

  def new
    @story = current_author.stories.build
  end

  def create
    @story = current_author.stories.build(story_params)
    if @story.save
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def show
    @story = Story.find_by_id!(params[:id])
  end

  def edit
    @story = Story.find_by_id!(params[:id])
  end

  def update
    @story = Story.find_by_id!(params[:id])

    if @story.update(story_params)
      flash[:alert] ="Your story was updated!"
      redirect_to author_stories_path(@story)
    else
      render :edit
    end
  end

  def destroy
    Story.find_by_id!(params[:id]).destroy
    redirect_to author_stories_path
  end

  private
  def story_params
    params.require(:story).permit(:story_title, :story)
  end
end
