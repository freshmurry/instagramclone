Cloudinary.config do |config|
  config.cloud_name = 'cloud_name'
  config.api_key = ENV["CLOUDINARY_API_KEY"]
  config.api_secret = ENV["CLOUDINARY_API_SECRET"]
  config.secure = true
  config.cdn_subdomain = true
end