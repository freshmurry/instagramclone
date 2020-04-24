class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :bookmarks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter]

  validates :name, presence: true, length: {maximum: 50}
  has_attached_file :avatar
  validates_attachment :avatar,
    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
    
  # def total_followers
  #   "#{username}"
  # end
  
  # def total_following
  #   Folower.where(following_id: self.id).count
  # end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image.gsub!("_normal", "") # assuming the user model has an image
      user.uid = auth.uid
      user.provider = auth.provider
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      nil
    end
  end

  
  def edit
  end
  
  def user_params
    params.require(:user).permit(:username, :name, :website, :bio, :email, :avatar)
  end
end