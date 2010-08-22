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

  def tag_cloud_generator(model)
    url_proc = params.kind_of?(Hash) ? (proc {|tag| tag ? params.merge(:tag => tag.name) : "#" }) : params
    @tag_selected ||= params[:tag]
    result = '<div class="tag-cloud" class="box">'
    result << "<h2>#{t("tag_cloud.title")}</h2>"
    result << "<div class='content'>"
    tag_cloud(model.tag_counts_on(:tags), %w(tag1 tag2 tag3 tag4 tag5)) do |tag, css_class|
      selected = @tag_selected == tag.name
      css_class = "#{css_class} selected" if selected
      result << link_to(tag.name,url_proc.call(selected ? nil : tag), :class => css_class) 
    end
    result << '</div></div>'
    return result.html_safe
  end
end

require 'action_view/base'
class ActionView::Base
  include XiraxiCore::PageHelpers
end
