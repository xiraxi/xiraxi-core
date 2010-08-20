module XiraxiCore::Controller

  def not_found
    render :partial => "status/not_found", :status => 404
  end

end

class ActionController::Base
  include XiraxiCore::Controller
end
