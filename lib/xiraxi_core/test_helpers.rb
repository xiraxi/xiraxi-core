require "capybara/rails"

class ActiveSupport::TestCase
  def self.use_capybara!
    include Capybara
    include ExtraCapybaraHelpers
  end
end

module ExtraCapybaraHelpers
  def assert_xpath(xpath, message = nil)
    assert page.has_xpath?(xpath), message || "page sould have #{xpath}"
  end

  def assert_not_xpath(xpath, message = nil)
    assert !page.has_xpath?(xpath), message || "page sould hot have #{xpath}"
  end

  def assert_flash_box(content, flash_type = nil)
    box = find(:css, flash_type ? "div.flash-box.#{flash_type}" : "div.flash-box")
    assert_not_nil box
    assert_match content, box.native.inner_text
  end

  def cookies
    # So ugly...
    Capybara.current_session.driver.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
  end

  def clear_session_cookies
    cookies = self.cookies
    cookies.send(:hash_for).each_pair do |name, cookie|
      if cookie.expires.nil?
        cookies[name] = nil
      end
    end
  end
end

# Needed for test emails
unless ActionMailer::Base.default_url_options[:host]
  ActionMailer::Base.default_url_options[:host] = "localhost"
end

class HTML::Node
  def text
    if HTML::Text === self
      to_s
    else
      children.map {|tag| tag.text }.join
    end
  end
end
