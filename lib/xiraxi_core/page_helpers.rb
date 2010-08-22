module XiraxiCore::PageHelpers

  def flash_box(type, content = flash[type])
    if content
      %[<div class="flash-box #{h type}">#{h content}</div>].html_safe
    end
  end

  def field_label(model, field)
    model.human_attribute_name(field)
  end

  def link_button_edit(url)
    link_to(t("actions.edit"), url, :class => "button")
  end

  def link_button_delete(url)
    link_to(t("actions.delete"), url, :class => "button", :method => :delete, :confirm => t("confirm.delete"))
  end

end

require 'action_view/base'
class ActionView::Base
  include XiraxiCore::PageHelpers
end
