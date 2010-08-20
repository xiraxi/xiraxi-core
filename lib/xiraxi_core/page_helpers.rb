module XiraxiCore::PageHelpers

  def flash_box(type, content = flash[type])
    if content
      %[<div class="flash-box #{h type}">#{h content}</div>].html_safe
    end
  end

end

require 'action_view/base'
class ActionView::Base
  include XiraxiCore::PageHelpers
end
