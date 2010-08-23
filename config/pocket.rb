
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


class ClousureCompressor
  def compress(content)
    if `which java`.empty?
      STDERR.puts "*** Java was not found in your path."
      STDERR.puts "*** You can install it with openjdk-6-jre-headless"
      STDERR.puts "*** Java is needed for Google Clousure Compressor was not found."
      STDERR.puts "*** The JavaScript code will be generated without any compression."
      return content
    end

    jar_file = File.expand_path("~/.javascript_closure_compiler/compiler.jar")
    if not File.exist?(jar_file)
      STDERR.puts "*** Google Clousure Compressor was not found."
      STDERR.puts "*** You still can generate the JavaScript files, but they can not be compressed."
      STDERR.puts "*** It is recommended to download http://closure-compiler.googlecode.com/files/compiler-latest.zip and extract the compiler.jar file into #{jar_file}"
      return content
    end

    require "open3"
    stdin, stdout, stderr = Open3.popen3("java", "-jar", jar_file, "--compilation_level", "SIMPLE_OPTIMIZATIONS")
    stdin.write content
    stdin.close

    STDERR.write stderr.read
    compressed = stdout.read

    compressed
  end
end

compressor :clousure, :handler => ClousureCompressor.new

# Concats JavaScript files and compress them
js "public/javascripts/application.js" do
  compress :clousure

  paths.each do |path|
    use path.join("app/views/js/*.js").to_s
  end
end

# Copy jQuery to the public/javascripts
files "public/javascripts" do
  b = XiraxiCore.root.join("public/javascripts/").to_s
  base b
  use "#{b}/jquery.js"
end
