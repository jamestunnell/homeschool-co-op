Cloudinary.config do |config|
  config.cloud_name = ENV["cloudinary_cloud_name"]
  config.api_key = ENV["cloudinary_api_key"]
  config.api_secret = ENV["cloudinary_secret"]
  config.cdn_subdomain = true
  config.enhance_image_tag = true
  config.static_image_support = false
end