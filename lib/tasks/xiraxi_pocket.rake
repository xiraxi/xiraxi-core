
namespace :pocket do

  desc "Update the pocket using AssetPocket"
  task :update => :environment do
    require 'asset_pocket/generator'
    generator = AssetPocket::Generator.new
    generator.root_path = Rails.root

    pocket_definition = []
    Rails.application.railties.engines.map do |engine|
      file = Rails.root.join("config/pocket.rb")
      pocket_definition << file.read if file.exist?
    end
    generator.parse_string pocket_definition.join
    generator.run!
  end
end
