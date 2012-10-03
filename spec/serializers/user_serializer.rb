class UserSerializer
  def initialize(user)
    @user = user
  end

  def to_json(options = {})
    @user.to_json(include: :posts)
  end
end
