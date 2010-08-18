
module FindByQuery
    def find_by_query(query)
        cx = Capybara::XPath

        [
            # Query by node content
            cx.content(query),

            # By ID, using '-' as separator
            cx.from_css("#" + query.gsub(" ", "-")),

            # By ID, using '_' as separator
            cx.from_css("#" + query.gsub(" ", "_")),

            # By class name, using '-' as separator
            cx.from_css("." + query.gsub(" ", "-")),

            # By class name, using '_' as separator
            cx.from_css("." + query.gsub(" ", "_")),

            # Using the special data-locator attribute
            "*[@data-locator=#{cx.escape query}]"

        ].each do |xpath_query|
            results = all(:xpath, xpath_query)
            if results.size > 0
                return results.first
            end
        end

        raise Capybara::ElementNotFound, "Unable to locate #{query}"
    end
end

World(FindByQuery)
