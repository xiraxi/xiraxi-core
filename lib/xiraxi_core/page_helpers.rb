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
    content_for :header, csrf_meta_tag
    link_to(t("actions.delete"), url, :class => "button", :method => :delete, :confirm => t("confirm.delete"))
  end

  def tag_cloud_generator(model)
    url_proc = params.kind_of?(Hash) ? (proc {|tag| tag ? params.merge(:tag => tag.name) : "#" }) : params
    @tag_selected ||= params[:tag]
    result = '<div class="tag-cloud" class="box">'
    result << "<h2>#{t("tag_cloud.title")}</h2>"
    result << "<div class='content'><ul><p>Etiquetas:</p>"
    tag_cloud(model.tag_counts_on(:tags), %w(tag1 tag2 tag3 tag4 tag5)) do |tag, css_class|
      result << '<li>' 
      selected = @tag_selected == tag.name
      css_class = "#{css_class} selected" if selected
      result << link_to(tag.name,url_proc.call(selected ? nil : tag), :class => css_class) 
      result << '</li>' 
    end
    result << '</ul></div></div>'
    return result.html_safe
  end

  def locales(&block)
    # Some controllers (like StaticPages) can override #locales using locales_iterator to provide
    # alternative localized pages
    locales_iterator(&block)
  end

  def locales_iterator(&block)
    I18n.available_locales.each do |locale|
      block.call(:locale => locale,
                 :label => t("locale.label", :locale => locale),
                 :active => locale.to_s == I18n.locale.to_s,
                 :path_to_set => set_locale_path(locale))
    end
  end
end

require 'action_view/base'
class ActionView::Base
  include XiraxiCore::PageHelpers
end
