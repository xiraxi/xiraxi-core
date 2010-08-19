module XiraxiCore::FormHelpers
  def buttons_bar(&block)
    "<div class='buttons_bar'>#{with_output_buffer(&block)}</div>".html_safe
  end

  def button_ok
    content_tag("button", t("buttons.ok"), :class => "ok-button", :type => "submit")
  end

  def button_cancel(url)
    link_to(t("buttons.cancel"), url, :class => "button cancel-button")
  end
end

require 'action_view/base'
class ActionView::Base
  include XiraxiCore::FormHelpers
end
