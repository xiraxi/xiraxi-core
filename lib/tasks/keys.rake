
namespace :keys do

  desc "Initialize (if not yet) the XiraxiCore::Security keys"
  task :init => :environment do
    unless XiraxiCore::Security.keys_file.exist?
      XiraxiCore::Security.load.save_keys
    end
  end

end
