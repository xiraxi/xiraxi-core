
class XiraxiCore < Rails::Engine
  config.community = ActiveSupport::OrderedOptions.new
  config.community.web_name = "Unnamed Xiraxi Instance"
  config.community.default_mail = "manager@xiraxi"

  initializer :after => "xiraxi_core.external_migrations" do
    Rails.application.railties.engines.each do |engine|
      migrations_dir = engine.root.join("db/migrate")
      if migrations_dir.directory?
        ActiveRecord::Migrator.add_external_sources engine.class.name.underscore, migrations_dir
      end
    end
  end
end
