class ShortcutsController < ApplicationController
  before_action :set_app

  def index
    shortcuts = @app.shortcuts.order(updated_at: :desc)
    render json: shortcuts
  end

  def create
    shortcut = @app.shortcuts.new(shortcut_params)

    if shortcut.save
      render status: 200, json: {
          message: "Successfully created shortcut",
          shortcut: shortcut
      }
    else
      render status: 422, json: {
          message: "Unsuccessful, There was #{pluralize(shortcut.errors.size, "error")}",
          errors: shortcut.errors.full_messages,
      }
    end
  end

  def update
    shortcut = @app.shortcuts.find(params[:id])
    if shortcut.update(shortcut_params)
      render status: 200, json: {
          message: "Successfully updated shortcut",
          shortcut: shortcut
      }
    else
      render status: 422, json: {
          message: "Unsuccessful, There was #{pluralize(shortcut.errors.size, "error")}",
          errors: shortcut.errors.full_messages,
      }
    end
  end

  def destroy
    shortcut = @app.shortcuts.find(params[:id])
    shortcut.destroy
    render status: 200, json: {
        message: "Successfully deleted shortcut"
    }
  end

  private
  def set_app
    @app = current_user.apps.find(params[:app_id])
    unless @app
      render_404
    end
  end

  def shortcut_params
    params.permit(:action_name, :first_action, :second_action, :third_action, :fourth_action)
  end
end
