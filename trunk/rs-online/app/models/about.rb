class About
  attr_accessor :name, :bio, :email, :twitter, :website, :url_photo

  def initialize name, bio, email, twitter, website, url_photo
    @name = name
    @bio = bio
    @email = email
    @twitter = twitter
    @website = website
    @url_photo = url_photo
  end
end
