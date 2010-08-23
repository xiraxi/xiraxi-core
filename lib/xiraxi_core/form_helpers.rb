module XiraxiCore::FormHelpers
  def buttons_bar(&block)
    "<div class='buttons_bar'>#{with_output_buffer(&block)}</div>".html_safe
  end

  def button_ok(options = {})
    content_tag("button", options[:label] || t("buttons.ok"), :class => "ok-button", :type => "submit")
  end

  def button_cancel(url = { :action => :index })
    link_to(t("buttons.cancel"), url, :class => "button cancel-button")
  end


  def error_messages_for(record)
    return '' if record.nil? or record.errors.empty?

    result = %[ <div class="error form-messages"> <h2>#{t "forms.errors.header", :count => record.errors.count}</h2> <ul> \n]
    record.errors.full_messages.each do |msg|
      result << %[<li>#{ h msg }</li>]
    end

    (result + "</ul> </div>").html_safe
  end
end

require 'action_view/base'
class ActionView::Base
  include XiraxiCore::FormHelpers
end

module XiraxiCore::FormBuilderHelpers
  def hidden_label(*args, &block)
    @template.content_tag :div, label(*args, &block), :style => "position: absolute; left: -1000px"
  end
end

class  ActionView::Helpers::FormBuilder
  include XiraxiCore::FormBuilderHelpers
end

