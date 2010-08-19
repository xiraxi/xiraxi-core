
Then /^the flash box contains "([^"]*)"$/ do |content|
  page.should have_css(".flash-box")
  find(:css, ".flash-box").text.should include(content)
end
