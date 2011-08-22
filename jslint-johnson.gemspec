# -*- encoding: utf-8 -*-
require File.expand_path("lib/jslint-johnson/version", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name = %q{jslint-johnson}
  s.version = JSLintJohnson::Version::STRING
  s.platform = Gem::Platform::RUBY

  s.authors = ["William Howard"]
  s.email = %q{whoward.tke@gmail.com}
  s.homepage = %q{http://github.com/whoward/jslint-johnson}

  s.default_executable = %q{jslint-johnson}
  s.executables = ["jslint-johnson"]

  s.extra_rdoc_files = ["README.markdown"]

  s.require_paths = ["lib"]

  s.summary = %q{JSLint CLI and rake tasks via johnson}
  s.description = "Ruby gem wrapper for a jslint cli.  Uses the Johnson library for performance reasons targeted for usage in CI environments and backed up with a full test suite."  
  
  s.files = Dir.glob("lib/**/*.rb") + Dir.glob("lib/**/*.js") + %w(Gemfile Gemfile.lock bin/jslint-johnson)
  s.test_files = Dir.glob("test/**/*.rb")

  s.add_dependency "johnson", "~> 1.2.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "test-unit"
end

