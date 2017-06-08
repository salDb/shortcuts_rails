class ApplicationController < ActionController::Base
  include SessionsHelper
  include ActionView::Helpers::TextHelper
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def render_404
    render status: 404, json: {
        message: "Record not found"
    }
  end

  def logged_in?
    !!current_user
  end

  def current_user
    if auth_present? && !auth.empty?
      user = User.find(auth["user"])
      if user
        @current_user ||= user
      end
    end
  end

  def authenticate
    if !logged_in?
      render json: {error: "unauthorized, token: #{request.headers["Accept"]}"}, status: 401
    end
  end

  private

  def token
    request.headers["AUTHORIZATION"]
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    !!request.headers["AUTHORIZATION"]
  end
end