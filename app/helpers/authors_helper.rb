module AuthorsHelper
  def display_name(author)
    "#{author.first_name} #{author.last_name}"
  end
end
