module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id, user_type)
    JsonWebToken.encode(user_id: user_id, user_type: user_type)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id, user_type)
    JsonWebToken.encode({ user_id: user_id, user_type: user_type },
                        (Time.now.to_i - 10))
  end

  def authorization_header(token)
    request.headers['Authorization'] = "Bearer #{token}"
  end
end
