require 'rubygems'
require 'rake'
require 'jeweler'
require File.join(File.dirname(__FILE__), 'lib', 'jslint-johnson', 'version')

Jeweler::Tasks.new do |gem|
  gem.name        = "jslint-johnson"
  gem.summary     = "JSLint CLI and Rake tasks via Johnson and Thor"
  #gem.description = "TODO: longer description"

  gem.homepage       = "http://github.com/whoward/jslint-johnson"
  gem.authors        = ["William Howard"]
  gem.email          = "whoward.tke@gmail.com"

  gem.version = JSLintJohnson::Version::STRING

  gem.files.include 'lib/**/*.rb'
  gem.files.exclude ''
end

# require every *.rake file inside of the tasks subdirectory
Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rake')].each {|f| load f}
