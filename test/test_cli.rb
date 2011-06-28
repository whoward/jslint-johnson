require 'test/unit'
require 'erb'

class TestCli < Test::Unit::TestCase
  Executable = File.expand_path("../bin/jslint-johnson", File.dirname(__FILE__))

  ValidFile = File.expand_path("fixtures/valid.js", File.dirname(__FILE__))
  InvalidFile = File.expand_path("fixtures/invalid.js", File.dirname(__FILE__))

  ValidExpectedOutputFile = File.expand_path("fixtures/cli-valid-expected-output.txt.erb", File.dirname(__FILE__))
  InvalidExpectedOutputFile = File.expand_path("fixtures/cli-invalid-expected-output.txt.erb", File.dirname(__FILE__))

  def test_executable_exists
    assert File.exist?(Executable)
  end

  def test_empty_args
    result = `#{Executable}`

    assert_equal "usage: #{File.basename(Executable)} FILES\n", result
    assert_equal false, $?.success?
  end

  def test_valid
    result = `#{Executable} \"#{ValidFile}\"`

    assert $?.success?

    expected = ::ERB.new(File.read(ValidExpectedOutputFile)).result

    assert_equal expected.strip, result.strip
  end

  def test_invalid
    result = `#{Executable} \"#{InvalidFile}\"`

    assert_equal false, $?.success?

    expected = ::ERB.new(File.read(InvalidExpectedOutputFile)).result

    assert_equal expected.strip, result.strip
  end

end