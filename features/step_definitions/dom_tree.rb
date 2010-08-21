
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

Then /^the "([^"]*)" box has these boxes in the same order:$/ do |box, table|
  rows = table.raw.dup
  row_waiting = true
  field = content = nil

  find_by_query(box).node.search("*").each do |node|
    next unless node.element?

    if row_waiting
      field, content = rows.shift
      break if field.nil?

      field = field.downcase.tr(' ', '_')
      row_waiting = false
    end

    if  node["id"].to_s.downcase == field ||                         # ID
        " #{node["class"].to_s.downcase} ".include?(" #{field} ") || # CSS class
        node["data-locator"].to_s.downcase == field

      node.inner_text.to_s.should include(content)
      row_waiting = true

    end
  end

  rows.should eql([])
end
