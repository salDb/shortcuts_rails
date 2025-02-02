class AppsController < ApplicationController
  before_action :set_app, only: [:show, :update, :destroy]

  def index
    if params[:app_type] == 'shortcuts'
      @apps = current_user.apps.where(app_type: 'shortcuts').order(updated_at: :desc)
    else
      @apps = current_user.apps.where(app_type: 'commands').order(updated_at: :desc)
    end
    render :json => @apps.to_json(only: [:id, :name], methods: [:image_url])
  end

  def show
    render json: @app.as_json(only: [:id, :name], methods: [:image_url])
  end

  def create
    @app = current_user.apps.new(app_params)

    if @app.save
      render status: 200, json: {
          message: "Successfully created new app",
          app: @app
      }
    else
      render status: 422, json: {
          message: "Unsuccessful, There was #{pluralize(@app.errors.size, "error")}",
          errors: @app.errors.full_messages,
      }
    end
  end

  def update
    if @app.update(app_params)
      render status: 200, json: {
          message: "Successfully updated app",
          app: @app.as_json(only: [:id, :name], methods: [:image_url])
      }
    else
      render status: 422, json: {
          message: "Unsuccessful, There was #{pluralize(@app.errors.size, "error")}",
          errors: @app.errors.full_messages,
      }
    end
  end

  def destroy
    @app.destroy
    render status: 200, json: {
        message: "Successfully deleted app"
    }
  end

  private
  def set_app
    @app = current_user.apps.find(params[:id])
    unless @app
      render_404
    end
  end

  def app_params
    params.permit(:name, :image, :app_type)
  end
end
