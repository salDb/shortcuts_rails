class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render status: 200, json: {
          message: "Successfully created a new account",
      }
    else
      render status: 422, json: {
          message: "Unsuccessful, There was #{pluralize(user.errors.size, "error")}",
          errors: user.errors.full_messages
      }
    end
  end

  def update
    if current_user.update(user_params)
      render status: 200, json: {
          message: "Successfully updated your account",
      }
    else
      render status: 422, json: {
          message: "Unsuccessful, There was #{pluralize(current_user.errors.size, "error")}",
          errors: current_user.errors.full_messages
      }
    end
  end

  private
  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
