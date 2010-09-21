class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found
    render :partial => "status/not_found", :status => 404
  end

  def forbidden
    render :partial => "status/forbidden", :status => 403
  end

  before_filter :load_locale_from_session
  def load_locale_from_session
    I18n.locale = session[:current_locale] || request.preferred_language_from(I18n.available_locales.map {|l| l.to_s}) || I18n.default_locale
  end
end
