class StoriesController < ApplicationController
  before_action :authenticate_author!

  def index
    @author = current_author
  end

  def new
    @story = Story.new
    @author = current_author
  end

  def create
    @story = Story.new(story_params)
    @story.author_id = current_author.id
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
