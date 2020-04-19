class ApplicationController < ActionController::Base
  helper_method :current_author, :logged_in?, :authenticate_author!

  private

  def current_author
    @current_author ||= Author.find_by(id: session[:author_id])
  end

  def logged_in?
    !!current_author
  end

  def authenticate_author!
    redirect_to login_path if !logged_in?
  end

  def is_admin?
    redirect_to author_stories_path(current_author) unless current_author.admin
  end
end
