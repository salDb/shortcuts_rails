class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      jwt = Auth.issue({user: user.id})
      render json: {
          message: "Successfully logged in",
          auth_token: jwt,
          user_id: user.id
      }
    else
      render json: {message: "Could not autheticate user"}, status: 401
    end
  end
end
