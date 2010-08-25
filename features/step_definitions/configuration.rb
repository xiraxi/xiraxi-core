Given /^"([^"]*)" configuration for "([^"]*)" is ([^"]*)$/ do |plugin, element, value|
  case value
  when 'nil'
    Rails.application.config.send(plugin).send("[]=", element, nil)
  when 'true'
    Rails.application.config.send(plugin).send("[]=", element, true)
  when 'false'
    Rails.application.config.send(plugin).send("[]=", element, false)
  when /^[+-]?[0-9_]+(\.\d+)?$/
    Rails.application.config.send(plugin).send("[]=", element, value.to_f)
  else
    Rails.application.config.send(plugin).send("[]=", element, value)
  end
end
