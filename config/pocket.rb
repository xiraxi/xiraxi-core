
paths = Rails.application.railties.engines.map {|e| e.root }
paths.push Rails.root

# Load every stylesheet in application.css
sass "public/stylesheets/application.css" do

  # First load the basics/*.scss and then the rules
  ["basics/", ""].each do |prefix|
    paths.reverse.each do |path|
      Dir[path.join("app/views/css/#{prefix}*.scss")].each do |scss_name|
        @content << [ :string, "/* Loaded from #{scss_name} */\n" ]
        @content << [ :string, File.read(scss_name) ]
      end
    end
  end
end

paths.each do |path|
  files "public/images" do
    base "#{path}/app/views/images"
    use "#{path}/app/views/images/**/*"
  end
end

