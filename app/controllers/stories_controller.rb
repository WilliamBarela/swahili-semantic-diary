class StoriesController < ApplicationController

  def index
    @author = current_author
  end

  def new
  end
end
