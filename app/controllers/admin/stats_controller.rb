class Admin::StatsController < ApplicationController

  before_action :authenticate_author!
  before_action :redirect_if_not_admin

  def index
  end
end
