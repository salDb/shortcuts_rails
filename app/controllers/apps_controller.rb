class AppsController < ApplicationController
  before_action :set_app, only: [:show, :update, :destroy]
   
  def index
    @apps = App.all

    render json: @apps
  end

  def show
    render json: @app
  end
   
  def create
    @app = App.new(app_params)

    if @app.save
      render json: @app, status: :created, location: @app
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end
   
  def update
    if @app.update(app_params)
      render json: @app
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end
   
  def destroy
    @app.destroy
  end

  private
     
    def set_app
      @app = App.find(params[:id])
    end
     
    def app_params
      params.permit(:name, :image)
    end
end
