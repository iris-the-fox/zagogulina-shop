class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error

  def render_404
    render :template => "errors/error_404", :status => 404
  end

  private 

  def authenticate_admin
      redirect_to root_path, alert: "You're not authorized for this action" unless current_user.try(:admin?)
  end

  def handle_error(e)
    flash[:alert] = "There is no record with such id"
    redirect_to :action => 'index'
  end

end
