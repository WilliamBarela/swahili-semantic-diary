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
      redirect_to author_stories_path
    else
      render :new
    end
  end

  private
  def story_params
    params.require(:story).permit(:story_title, :story)
  end
end
