class Auth::AuthenticateUser
  def initialize(email, password, user_type)
    @email = email
    @password = password
    @user_type = user_type
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password, :user_type

  # verify user credentials
  def user
    user = user_type.constantize.find_by(email: email)
    return user if user && user.authenticate(password)

    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
