
When /^I submit the form "([^"]+)"$/ do |selector|
  with_scope(selector) do
    find(:xpath, "//*[@type=\"submit\"]").click
  end
end

When /^I submit the form$/ do
  find(:css, "form:last button").click
end

When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" date$/ do |date_to_select, field_name|
  date_to_select = Date.parse(date_to_select)
  date_to_select = [date_to_select.year, date_to_select.strftime("%B"), date_to_select.day]

  all(:xpath, %|//select[contains(@name,#{Capybara::XPath.escape("[#{field_name}(".downcase.tr(" ", "_"))})]|).each do |node|
    if node["id"] =~ /_(\d+)i$/
      select date_to_select[$1.to_i - 1].to_s, :from => node["id"]
    end
  end
end

Then /^these fields have errors: (.*)$/ do |fields|
  fields.split(/\s*,\s*/).each do |field|
    within(:css, "div.field_with_errors") do
      find_by_query(field).should_not be_nil
    end
  end
end
