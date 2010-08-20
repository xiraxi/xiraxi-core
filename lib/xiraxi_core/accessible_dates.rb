
require 'action_view/helpers/date_helper'
class ActionView::Helpers::DateTimeSelector
  def build_select_with_accessible(type, select_options_as_html)
    content_tag("label", I18n.t("accessible.date_select.#{type}"), :style => "position: absolute; left: -10000px", :for => (@html_options[:id] || input_id_from_type(type))) + \
      build_select_without_accessible(type, select_options_as_html)
  end

  alias_method_chain :build_select, :accessible

end

