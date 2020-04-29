class Author < ApplicationRecord
  has_secure_password

  has_many :words, dependent: :destroy

  has_many :stories, dependent: :destroy

  scope :most_stories, -> { left_joins(:stories).group("authors.id").order("COUNT(stories.author_id) DESC") }

  # READ: https://www.postgresql.org/docs/9.6/functions-matching.html#FUNCTIONS-POSIX-TABLE
  scope :find_author, ->(search_params) { where("first_name ~* ?", "^#{search_params[:query]}")}

  validates :first_name, :last_name, :email,
    presence: true

  validates :email,
    uniqueness: true

  validate :valid_password?

  def valid_password?
    errors.add(:password, "must be between 8 and 32 characters.") unless self.password.nil? or self.password.length.between?(8,32)
  end

  def self.find_or_create_by_omniauth(auth_hash)
    oauth_username = auth_hash["extra"]["raw_info"]["login"]

    unless author = Author.find_by(:username => oauth_username)
      author = Author.new(:username => oauth_username, :password => SecureRandom.hex)
      author.save!(:validate => false)
    end

    return author
  end

  # replaced by scope method :most_stories
  # def self.most_stories
  #   Author
  #     .left_joins(:stories)
  #     .group("authors.id")
  #     .order("COUNT(stories.author_id) DESC")
  # end
end
