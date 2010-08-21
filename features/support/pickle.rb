
Dir[Rails.root.join("features/factories/*.rb")].each {|filename| require filename }

require 'pickle/world'

Pickle.configure do |config|
   config.adapters = [:factory_girl]
   #config.map 'I', 'myself', 'me', 'my', :to => 'user: "me"'
end


# Extensions to Pickle
module Pickle::Session::Parser

  # Redefined to support expressions in tables
  def parse_hash(hash)
    hash.inject({}) do |parsed, (key, val)|
      if session && val =~ /^#{capture_model}$/
        parsed.merge!(key => session.model($1))
      elsif val =~ /^\s*(\d+)\s*(minutes?|days?|seconds?)\s*ago\s*$/
        parsed.merge!(key => $1.to_i.send($2).ago)
          parsed
      else
        parsed.merge!(key => val)
      end
    end
  end
end
