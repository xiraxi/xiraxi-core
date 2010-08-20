
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


