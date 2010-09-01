
# Using XT (Xiraxi Tests) we can debug the output generated
# Possible values
#   f    Save it on /tmp/cucumber_output.XXX.html
#   s    Dump to stderr
After do |scenario|
  next unless scenario.failed?

  case ENV["XT"]
  when "s"
    STDERR.puts page.body
  when "f"
    n = 0
    while n < 1000
      n += 1
      path = Pathname.new("/tmp/cucumber_output.%03d.html" % n)
      unless path.exist?
        path.open("w") {|f| f.write page.body }
        break
      end
    end
    STDERR.puts "Output written to #{path}"
  end
end
