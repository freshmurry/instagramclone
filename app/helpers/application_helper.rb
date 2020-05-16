# module ApplicationHelper
#   def avatar user
#     return user.image if user.image
#     gravatar_id = Digest::MD5::hexdigest(user.email).downcase
#     "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
#   end
# end

module ApplicationHelper
  def avatar(user)
    if user.image
      "http://graph.facebook.com/#{user.uid}/picture?type=large"
    else
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
    end
  end
end