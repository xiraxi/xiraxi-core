
Then /^the flash box contains "([^"]*)"$/ do |content|
  page.should have_css(".flash-box")
  find(:css, ".flash-box").text.should include(content)
end

Then /^the current page is a "([^"]*)" action$/ do |action_name|
  Rails.application.routes.recognize_path(current_path, Caulfield.env)[:action].should eql(action_name)
end

Then /^I see (\d+) "([^"]+)" boxes/ do |count, css_class|
  all(:css, ".#{css_class}").size.should eql(count.to_i)
end
