module AuthorsHelper
  def display_name(author)
    "#{author.first_name} #{author.last_name}"
  end

  def possessive_display_name(author)
    name = display_name(author)
    name[-1] == "s" ? "#{name}'" : "#{name}'s"
  end
end
