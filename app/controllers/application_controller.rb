class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActionController::UnknownController, with: :render_404

  protect_from_forgery with: :exception
  before_filter :set_locale
  force_ssl except: :check unless Rails.env.development?

  def render_404
    @not_found_path = params[:path]
    respond_to do |format|
      format.html { render template: 'errors/not_found', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end


  private
  def set_locale
    I18n.locale = env['rack.locale']
    logger.debug "* Locale set to '#{I18n.locale}'"
  end


end
