module XiraxiCore::Controller

  def not_found
    render :partial => "status/not_found", :status => 404
  end

  def forbidden
    render :partial => "status/forbidden", :status => 403
  end

end

class ActionController::Base
  include XiraxiCore::Controller
end
