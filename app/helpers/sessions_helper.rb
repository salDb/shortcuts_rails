require 'jwt'

module SessionsHelper
  class Auth

    ALGORITHM = 'HS256'

    def self.issue(payload)
      JWT.encode(
          payload,
          ENV["AUTH_SECRET"],
          ALGORITHM)
    end

    def self.decode(token)
      begin
        JWT.decode(token,
                   ENV["AUTH_SECRET"],
                   true,
                   { algorithm: ALGORITHM }).first
      rescue JWT::VerificationError
        ""
      end
    end
  end
end
