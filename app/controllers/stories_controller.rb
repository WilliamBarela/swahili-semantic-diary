class StoriesController < ApplicationController
  before_action :authenticate_author!

  def index
    @author = current_author
  end

  def new
  end
end
