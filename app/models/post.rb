class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> {order(:created_at => :desc)}
  has_many :comments, -> {order(:created_at => :desc)}
  has_many :bookmarks
  
  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags

  after_commit :create_hash_tags, on: :create
  
  # scope :of_followed_users, -> (following_users) { where user_id: following_users }

  def is_belongs_to? user
    Post.find_by(user_id: user.id, id: id)
  end

  def is_liked user
    Like.find_by(user_id: user.id, post_id: id)
  end

  def is_bookmarked user
    Bookmark.find_by(user_id: user.id, post_id: id)
  end
  
  def create_hash_tags
    extract_name_hash_tags.each do |name|
      hash_tags.create(name: name)
    end
  end
  
  def extract_name_hash_tags
    content.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end
  
  def post_params
    params.require(:post).permit(:date, :time, :subject, :format, :copy, image: [:image_file_name, :image_file_size, :image_content_type, :image_updated_at])
  end
end