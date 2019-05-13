class Auth::AuthorizeApiRequest
  def initialize(headers = {}, user_type)
    @headers = headers
    @user_type = user_type
  end

  # Service entry point - return valid user object
  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers, :user_type

  def user
    # check if user type who trying to make request is the same user type
    # that encoded in token
    unless decoded_auth_token[:user_type] == user_type
      raise(ExceptionHandler::UnpermittedAccess, Message.unpermitted_access)
    end

    # check if user is in the database
    # memoize user object
    @user ||= user_type.constantize.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # check for token in `Authorization` header
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end

    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
