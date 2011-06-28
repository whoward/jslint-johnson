require File.expand_path('helper', File.dirname(__FILE__))

class TestRunner < Test::Unit::TestCase
  Fixtures = {
    :valid => File.expand_path("fixtures/valid.js", File.dirname(__FILE__)),
    :invalid => File.expand_path("fixtures/invalid.js", File.dirname(__FILE__)),
    :defined_globals => File.expand_path("fixtures/defined-globals.js", File.dirname(__FILE__)),
    :defined_options => File.expand_path("fixtures/defined-options.js", File.dirname(__FILE__))
  }

  def setup
    @runner = JSLintJohnson::Runner.new(%w(foo bar))
  end

  def test_lint_library_filename
    assert File.exist? JSLintJohnson::Runner::JSLintLibraryFilename
  end

  def test_file_list
    assert_equal @runner.file_list, %w(foo bar)
  end

  def test_constructor_enumerable_wrapping
    @runner = JSLintJohnson::Runner.new("foo")

    assert_equal @runner.file_list, %w(foo)
  end

  def test_file_not_found
    assert_raise RuntimeError do
      @runner.run
    end
  end

  def test_file_found
    assert_nothing_raised do
      JSLintJohnson::Runner.new(Fixtures[:valid]).run
    end
  end

  def test_runtime
    assert @runner.runtime.is_a?(Johnson::Runtime)
  end

  def test_runtime_caching
    first = @runner.runtime
    assert_equal @runner.runtime.object_id, first.object_id
  end

  def test_jslint_function_proxy
    assert_not_nil @runner.jslint_function
  end

  def test_jslint_result
    assert @runner.jslint_result.is_a?(Array)
  end

  def test_jslint_default_options
    assert @runner.jslint_options.keys.any?
  end

  def test_jslint_returns_array_of_errors
    result = @runner.jslint("if(true) alert('foo');")
    
    assert result.is_a?(Array)
    assert result.length > 0
    assert result.all? {|error| error.is_a?(JSLintJohnson::LintError) }
  end

  def test_run
    result = JSLintJohnson::Runner.new(Fixtures[:invalid]).run

    assert result.is_a?(Hash)
    assert result.keys.include?(Fixtures[:invalid])
    assert result[Fixtures[:invalid]].is_a?(Array)
  end

  def test_valid_run
    result = JSLintJohnson::Runner.new(Fixtures[:valid]).run

    errors = result[Fixtures[:valid]]

    assert errors.nil?
  end

  def test_invalid_run
    result = JSLintJohnson::Runner.new(Fixtures[:invalid]).run

    errors = result[Fixtures[:invalid]]

    assert errors.any?
  end

  def test_defined_globals
    result = JSLintJohnson::Runner.new(Fixtures[:defined_globals]).run

    errors = result[Fixtures[:defined_globals]]

    assert errors.nil?
  end

  def test_defined_options
    result = JSLintJohnson::Runner.new(Fixtures[:defined_options]).run

    errors = result[Fixtures[:defined_options]]

    assert errors.nil?
  end

  def test_block
    count = 0

    JSLintJohnson::Runner.new(Fixtures[:valid]).run do |file, errors|
      count += 1

      if count == 1
        assert_equal file, Fixtures[:valid]
        assert_equal errors, []
      end
    end

    assert_equal count, 1
  end

  def test_rejects_successful
    result = JSLintJohnson::Runner.new(Fixtures.values_at(:valid, :invalid)).run

    assert_equal result.keys.length, 1
  end
end
