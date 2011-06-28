require "rubygems"

# require the library code
require File.expand_path("../lib/jslint-johnson", File.dirname(__FILE__))

# require all test cases
Dir.glob(File.join(File.dirname(__FILE__), "test_*.rb")).each do |test_file|
  require test_file
end