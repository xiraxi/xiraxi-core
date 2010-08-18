
Then /^I see the "?([^"]*)"? (box|page)$/ do |selector, kind|

    case kind
    when "box"
        find_by_query(selector).should_not be_nil

    when "page"
        current_path.should == path_to("the #{selector} page")

    else
        pending
    end
end

