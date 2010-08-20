
class XiraxiCore < Rails::Engine
  config.community = ActiveSupport::OrderedOptions.new
  config.community.web_name = "Unnamed Xiraxi Instance"
  config.community.default_mail = "manager@xiraxi"
end
