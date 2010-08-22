
desc "Update the Xiraxi pocket"
task :pocket => :environment do
  require 'asset_pocket/generator'

  # Load every plugin pocket
  Rails.application.railties.engines.each do |engine|
    pocket_path = engine.root.join("config/pocket.rb")
    if pocket_path.exist?
      generator = AssetPocket::Generator.new
      generator.root_path = Rails.root
      generator.parse_string pocket_path.read
      generator.run!
    end
  end

end
