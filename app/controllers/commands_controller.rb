class CommandsController < ApplicationController
  before_action :set_app

  def index
    command = Command.all.where(app_id: @app.id).order(updated_at: :desc)
    render json: command
  end

  def create
    command = Command.new(command_params.merge!(app_id: @app.id))

    if command.save
      render status: 200, json: {
          message: "Successfully created command",
          command: command
      }
    else
      render status: 422, json: {
          message: "Unsuccessful, There was #{pluralize(command.errors.size, "error")}",
          errors: command.errors.full_messages,
      }
    end
  end

  def update
    command = Command.find_by({ app_id: @app.id, id: params[:id] })
    if command.update(command_params)
      render status: 200, json: {
          message: "Successfully updated command",
          command: command
      }
    else
      render status: 422, json: {
          message: "Unsuccessful, There was #{pluralize(command.errors.size, "error")}",
          errors: command.errors.full_messages,
      }
    end
  end

  def destroy
    command = Command.find_by({ app_id: @app.id, id: params[:id] })
    command.destroy
    render status: 200, json: {
        message: "Successfully deleted command"
    }
  end

  private
  def set_app
    @app = current_user.apps.find(params[:app_id])
    unless @app
      render_404
    end
  end

  def command_params
    params.permit(:command_description, :command)
  end
end
