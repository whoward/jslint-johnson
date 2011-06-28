require File.expand_path('helper', File.dirname(__FILE__))
require 'erb'

class TestCli < Test::Unit::TestCase
  Executable = File.expand_path("../bin/jslint-johnson", File.dirname(__FILE__))
  
  def test_executable_exists
    assert File.exist?(Executable)
  end

  def test_empty_args
    result = `#{Executable}`

    assert_equal "usage: jslint-johnson FILES\n", result
    assert_equal false, $?.success?
  end

  def test_valid
    result = `#{Executable} \"#{js_filename "valid"}\"`

    assert $?.success?
    assert_equal erb_fixture("cli-valid-expected-output"), result
  end

  def test_invalid
    result = `#{Executable} \"#{js_filename "invalid"}\"`

    assert_equal false, $?.success?
    assert_equal erb_fixture("cli-invalid-expected-output"), result
  end

end