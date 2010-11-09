require 'paperclip'
require 'http_accept_language'
require 'haml'

require 'xiraxi_core/multiload'
require 'xiraxi_core/form_helpers'
require 'xiraxi_core/page_helpers'
require 'xiraxi_core/accessible_dates'
require 'xiraxi_core/menu'
require 'xiraxi_core/security'

if Rails.env.test?
  require 'xiraxi_core/test_helpers'
end
