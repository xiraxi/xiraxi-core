module XiraxiCore::PageHelpers
 
  include WillPaginate::ViewHelpers::ActionView
  def will_paginate_with_i18n(collection, options = {}) 
    will_paginate_without_i18n(collection, options.merge(:previous_label => I18n.t("paginate.previous"), :next_label => I18n.t("paginate.next"))) 
  end 
  
  alias_method_chain :will_paginate, :i18n 

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
    result = '<div class="tag-cloud box">'
    result << "<h2>#{t("tag_cloud.title")}</h2>"
    result << "<div class='content'><p>#{t("tag_cloud.subtitle")}</p><ul>"
    tag_cloud(model.tag_counts_on(:tags), %w(tag1 tag2 tag3 tag4 tag5)) do |tag, css_class|
      result << "<li>#{link_to_tag(tag, {:css_class => css_class, :url_proc => url_proc})}</li>"
    end
    result << '</ul></div></div>'
    return result.html_safe
  end

  def tag_list(object)
    return "" if object.tags.empty?
    url_proc = params.kind_of?(Hash) ? (proc {|tag| tag ? params.merge(:tag => tag.name) : "#" }) : params
    @tag_selected ||= params[:tag]
    result = "<dl class='tags'><dt>#{ field_label object.class, :tags}</dt>"
    object.tags.each do |tag|
      result << "<dd>#{link_to_tag(tag, {:url_proc => url_proc})}</dd>"
    end
    result << "</dl>"
    return result.html_safe
  end

  def link_to_tag(tag, options = {})
    url_proc = options[:url_proc] || (params.kind_of?(Hash) ? (proc {|tag| tag ? params.merge(:tag => tag.name) : "#" }) : params)
    selected = @tag_selected == tag.name
    css_class = selected ? "#{options[:css_class]} selected" : options[:css_class]
    link_to(content_tag(:span, "tag:", :class => "hidden") + h(tag.name), url_proc.call(selected ? nil : tag), :class => css_class) 
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

  def locales_for_select
    I18n.available_locales.map do |locale|
      [ t("locale.label", :locale => locale), locale ]
    end
  end

  MenuChild = Struct.new :label, :url, :is_active, :generator
  def menu_iterator(menu)
    menu_item = MenuChild.new
    menu.each_child do |item|
      next unless item.visible?(controller)

      menu_item.label = item.label
      menu_item.url = item.path(controller)
      menu_item.is_active = item.selected?(controller)
      menu_item.generator = item
      yield menu_item
    end
  end
end

require 'action_view/base'
class ActionView::Base
  include XiraxiCore::PageHelpers
end
