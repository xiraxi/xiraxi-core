
Then /^I see the "?([^"]*)"? (box|page)$/ do |selector, kind|

  case kind
  when "box"
    find_by_query(selector).should_not be_nil

  when "page"

    case selector
    when "forbidden"
      page.status_code.should eql(403)
    else
      current_path.should == path_to("the #{selector} page")
    end

  else
    pending
  end
end

Then /^the "([^"]*)" box does not contain "([^"]*)"$/ do |locator, content|
  find_by_query(locator).text.should_not include(content)
end

Then /^the "([^"]*)" box contains "([^"]*)"$/ do |locator, content|
  find_by_query(locator).text.should include(content)
end

Then /^the page contains the "([^"]*)" box$/ do |locator|
  find_by_query(locator).should_not be_nil
end

Then /^the page does not contain the "([^"]*)" box$/ do |locator|
  proc { find_by_query(locator) }.should raise_error(Capybara::ElementNotFound)
end

Then /^the page contains "([^"]*)"$/ do |content|
  page.should have_content(content)
end
