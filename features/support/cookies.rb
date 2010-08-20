
module CookiesHack
  def cookie_jar
    # TODO This is a temp hack
    cj = ObjectSpace.each_object(Rack::Test::Session).to_a.first.instance_variable_get(:@rack_mock_session).cookie_jar
    unless cj.respond_to?(:each)
      class <<cj
        def each(&block)
          @cookies.each(&block)
        end

        def delete(cookie_name)
          @cookies.reject! {|cookie| cookie.name.to_s == cookie_name.to_s }
        end
      end
    end

    cj
  end
end

World(CookiesHack)
