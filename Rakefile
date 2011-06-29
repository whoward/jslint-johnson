require 'rubygems'
require 'rake'
require 'jeweler'
require File.join(File.dirname(__FILE__), 'lib', 'jslint-johnson', 'version')

Jeweler::Tasks.new do |gem|
  gem.name        = "jslint-johnson"
  gem.summary     = "JSLint CLI and rake tasks via johnson"
  gem.description = <<-EOS
    - Ruby gem wrapper for a JSLint CLI.
    - Uses the Johnson library for performance.
    - Targeted for usage in CI environments.
    - Thoroughly tested.
  EOS

  gem.homepage       = "http://github.com/whoward/jslint-johnson"
  gem.authors        = ["William Howard"]
  gem.email          = "whoward.tke@gmail.com"

  gem.version = JSLintJohnson::Version::STRING

  gem.add_dependency 'johnson', '~> 1.2.0'

  gem.executables = ['jslint-johnson']

  gem.files = Dir.glob("lib/**/*.rb") + Dir.glob("lib/**/*.js") + %w(Gemfile Gemfile.lock bin/jslint-johnson)
end
