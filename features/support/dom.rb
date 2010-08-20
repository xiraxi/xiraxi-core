
module XiraxiDomExtensions
    def find_by_query(query)
        cx = Capybara::XPath

        # We will ignore silently errors generanting XPath expressions
        [
            # Query by node content. Ignore nodes with children
            "//*[count(*)=0 and contains(normalize-space(.),#{cx.escape(query)})]",

            # By ID, using '-' as separator
            (cx.from_css("#" + query.gsub(" ", "-")) rescue nil),

            # By ID, using '_' as separator
            (cx.from_css("#" + query.gsub(" ", "_")) rescue nil),

            # By class name, using '-' as separator
            (cx.from_css("." + query.gsub(" ", "-")) rescue nil),

            # By class name, using '_' as separator
            (cx.from_css("." + query.gsub(" ", "_")) rescue nil),

            # Using the special data-locator attribute
            "//*[@data-locator=#{cx.escape query}]"

        ].compact.each do |xpath_query|
            results = all(:xpath, xpath_query)
            if results.size > 0
                return results.first
            end
        end

        raise Capybara::ElementNotFound, "Unable to locate \"#{query}\""
    end

    def submit_form(form)
        form = find_by_query(form) if form.kind_of?(String)
        form.find(:xpath, "//button").click
    end
end

World(XiraxiDomExtensions)
