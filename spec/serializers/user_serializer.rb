class UserSerializer
  def initialize(user)
    @user = user
  end

  def to_json(options = {})
    posts = {posts: @user.posts.as_json}
    user = @user.as_json
    user['user'].merge! posts
    JSON.generate user
  end
end
