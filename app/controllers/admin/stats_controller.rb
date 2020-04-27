class Admin::StatsController < ApplicationController

  before_action :authenticate_author!
  before_action :redirect_if_not_admin

  def index
    @most_stories = Author.most_stories
  end
end
