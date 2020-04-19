class ApplicationController < ActionController::Base
  helper_method :current_author, :logged_in?, :authenticate_author!, :is_admin?, :redirect_if_not_admin, :set_author_if_admin

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
    current_author.admin if current_author
  end

  def redirect_if_not_admin
    redirect_to author_stories_path(current_author) unless is_admin?
  end

  def set_author_if_admin(author_id)
    if is_admin?
      author = Author.find_by_id!(author_id)
    else
      author = current_author
    end
  end
end
