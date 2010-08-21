
module XiraxiCore::TestHelpers
    extend self

    def load_definitions

        # Definitions from engines
        Rails.application.railties.engines.each do |engine|
            features_dir = engine.root.join("features")
            if features_dir.directory?
                %w(support step_definitions factories).each do |base|
                    Dir["#{features_dir}/#{base}/*.rb"].each do |filename|
                      next if filename =~ /features\/support\/env\.rb$/

                      require filename
                    end
                end
            end
        end
    end
end
