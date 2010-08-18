
Dir[Rails.root.join("features/factories/*.rb")].each {|filename| require filename }

require 'pickle/world'

Pickle.configure do |config|
   config.adapters = [:factory_girl]
   #config.map 'I', 'myself', 'me', 'my', :to => 'user: "me"'
end

