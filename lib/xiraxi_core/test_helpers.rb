
module XiraxiCore::TestHelpers
  extend self

  def load_definitions
    %w(support factories step_definitions).each do |base|
      (Rails.application.railties.engines + [Rails]).flatten.each do |engine|
        features_dir = engine.root.join("features")
        if features_dir.directory?
          Dir["#{features_dir}/#{base}/*.rb"].each do |filename|
            next if filename =~ /features\/support\/env\.rb$/
            require filename
          end
        end
      end
    end
  end
end
