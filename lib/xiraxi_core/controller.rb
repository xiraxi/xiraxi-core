module XiraxiCore::Controller

  def not_found
    render :partial => "status/not_found", :status => 404
  end

  def forbidden
    render :partial => "status/forbidden", :status => 403
  end

  def self.included(cls)
    cls.before_filter :load_locale_from_session
  end

  def load_locale_from_session
    if locale = session[:current_locale]
      I18n.locale = locale
    end
  end

end

class ActionController::Base
  include XiraxiCore::Controller
end
