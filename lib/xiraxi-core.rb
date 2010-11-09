require 'migrext'

class XiraxiCore < Rails::Engine
  config.community = ActiveSupport::OrderedOptions.new
  config.community.web_name = "Unnamed Xiraxi Instance"
  config.community.default_mail = "manager@xiraxi"

  initializer :after => "xiraxi-core.external_migrations" do
    Rails.application.railties.engines.each do |engine|
      migrations_dir = engine.root.join("db/migrate")
      if migrations_dir.directory?
        ActiveRecord::Migrator.add_external_sources engine.class.name.underscore, migrations_dir
      end
    end
  end

  initializer :after => "xiraxi-core.order-load-paths" do
    pending_autoload_paths = ActiveSupport::Dependencies.autoload_paths.dup
    Rails.application.railties.engines.reverse.each do |engine|
      engine_root = engine.root.to_s
      pending_autoload_paths.dup.each do |path|
        if path.starts_with?(engine_root)
          pending_autoload_paths.delete path
          ActiveSupport::Dependencies.autoload_paths.delete path
          ActiveSupport::Dependencies.autoload_paths.push path
        end
      end
    end
    ActiveSupport::Dependencies.autoload_paths.reverse!
  end
end
