Gem::Specification.new do |s|
  s.name = "xiraxi-core"
  s.version = "0.2"
  s.date = "2010-08-17"
  s.authors = ["Xiraxi Foton Team"]
  s.email = "xiraxi@foton.es"
  s.summary = "Xiraxi Core"
  s.homepage = "http://xiraxi.foton.es"
  s.description = s.summary
  s.files = %w(app config db lib public rails tasks test features).map {|dir| Dir["#{dir}/*", "#{dir}/**/*" ] }.flatten

  s.add_dependency "asset-pocket"
  s.add_dependency "friendly_id", "~> 3.1"
  s.add_dependency "acts-as-taggable-on"
  s.add_dependency "paperclip"
  s.add_dependency "haml"
  s.add_dependency "asset-pocket"
  s.add_dependency "migrext", "= 0.2.1"
  s.add_dependency "will_paginate", "~> 3.0.pre2"

end
