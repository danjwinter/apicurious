class User < ActiveRecord::Base
  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"])
    user.email = auth["info"]["email"]
    user.nickname = auth["info"]["nickname"]
    user.name = auth["info"]["name"]
    user.image_url = auth["info"]["image"]
    user.token = auth["credentials"]["token"]
    # user.username = auth["extra"]["raw_info"]["login"]
    user.save
    user.github.create()
  end


end
