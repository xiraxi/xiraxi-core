
if ActiveRecord::Base.connection.tables.include?("translations")
  require 'i18n_backend'
  I18n.backend = XiraxiCore::I18nBackend.new
else
  STDERR.puts "translations table was not found. I18n can not be initialized"
end
