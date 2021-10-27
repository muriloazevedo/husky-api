module Auth
  class SendMagicLink
    def initialize(user)
      @user = user
    end

    def call
      generate_login_token!

      UserMailer.magic_link(user, login_link).deliver_now
    end

    private

    def generate_login_token!
      payload = {
        email: user.email,
        exp: 1.hour.from_now.to_i
      }
      user.login_token = generate_token(payload)
      user.save!
    end

    def login_link
      "http://localhost:3000/sessions?login_token=#{user.login_token}"
    end

    def generate_token(token_payload)
      JsonWebToken.encode(token_payload)
    end

    attr_reader :user
  end
end
