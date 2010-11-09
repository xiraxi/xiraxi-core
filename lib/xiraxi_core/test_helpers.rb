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

  def assert_flash_box(content, flash_type = nil)
    box = find(:css, flash_type ? "div.flash-box.#{flash_type}" : "div.flash-box")
    assert_not_nil box
    assert_match content, box.native.inner_text
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
