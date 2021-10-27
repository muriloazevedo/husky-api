module Auth
  class GenerateAuthToken

    def initialize(user)
      @user = user
    end

    def call
      generate_auth_token
    end

    private

    def generate_auth_token
      user.login_token = nil
      user.login_token_verified_at = Time.now
      user.save

      payload = {
        user_id: user.id,
        login_token_verified_at: user.login_token_verified_at,
        exp: 1.day.from_now.to_i
      }

      generate_token(payload)
    end

    def generate_token(token_payload)
      JsonWebToken.encode(token_payload)
    end

    attr_reader :user
  end
end
