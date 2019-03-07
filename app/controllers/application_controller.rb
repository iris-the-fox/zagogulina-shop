class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error
  rescue_from ActionController::RoutingError, with: -> { render_404  }

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  private 

  def authenticate_admin
      redirect_to root_path, alert: "You're not authorized for this action" unless current_user.try(:admin?)
  end

  def handle_error(e)
    flash[:alert] = "There is no record with id '#{params[:id]}"
    redirect_to :action => 'index'
  end

end
