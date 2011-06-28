require File.expand_path('helper', File.dirname(__FILE__))
require 'rake'
require 'tempfile'

class TestTask < Test::Unit::TestCase

  def setup
    # completely reset the rake application to ensure everything is clean
    Rake.application = nil
  end

  def test_creation
    initial_length = Rake.application.tasks.length

    JSLintJohnson::RakeTask.new

    # the number of tasks should have increased by 1
    assert_equal initial_length + 1, Rake.application.tasks.length
  end

  def test_default_name
    JSLintJohnson::RakeTask.new

    task = Rake.application.lookup("lint")

    assert_equal "lint", task.name
  end

  def test_default_description
    JSLintJohnson::RakeTask.new 

    task = Rake.application.lookup("lint")

    assert_equal "Runs the JSLint Test Suite", task.comment
  end

  def test_default_include_pattern
    task = JSLintJohnson::RakeTask.new 

    assert_equal "app/javascripts/**/*.js", task.include_pattern
  end

  def test_default_exclude_pattern
    task = JSLintJohnson::RakeTask.new

    assert_equal "", task.exclude_pattern
  end

  def test_default_output_stream
    task = JSLintJohnson::RakeTask.new

    assert_equal STDOUT, task.output_stream
  end

  def test_creation_block
    tempfile = Tempfile.new("foo")

    task = JSLintJohnson::RakeTask.new do |task|
      task.name = "foo"
      task.description = "Points out the bad codezzzz"
      task.include_pattern = "js/**/*.js"
      task.exclude_pattern = "js/**/*.txt"
      task.output_stream = tempfile
    end

    rake_task = Rake.application.lookup("foo")

    assert_equal "foo", rake_task.name
    assert_equal "Points out the bad codezzzz", rake_task.comment
    assert_equal "js/**/*.js", task.include_pattern
    assert_equal "js/**/*.txt", task.exclude_pattern
    assert_equal tempfile.object_id, task.output_stream.object_id
  end

  def test_files_to_run
    task = JSLintJohnson::RakeTask.new do |task|
      task.include_pattern = File.expand_path("fixtures/*", File.dirname(__FILE__))
      task.exclude_pattern = File.expand_path("fixtures/*.erb", File.dirname(__FILE__))
    end

    expected_files = Dir.glob(File.expand_path("fixtures/*.js", File.dirname(__FILE__)))

    assert_equal expected_files, task.files_to_run
  end

  def test_has_output
    result = String.new

    task = JSLintJohnson::RakeTask.new do |task|
      task.output_stream = StringIO.new(result, "w+")
    end

    rake_task = Rake.application.lookup("lint")

    assert_equal 0, result.length

    rake_task.invoke

    assert_not_equal 0, result.length
  end
end