require 'rake'
require 'rake/tasklib'

module JSLintJohnson
  class RakeTask < ::Rake::TaskLib
    # name of the rake task
    attr_accessor :name

    # description for the task
    attr_accessor :description

    # inclusion glob pattern for files
    attr_accessor :include_pattern

    # exclusion glob pattern for files
    attr_accessor :exclude_pattern

    # output stream for this task
    attr_accessor :output_stream

    def initialize
      # a default name
      @name = "lint"
      
      # a default description
      @description = "Runs the JSLint Test Suite"

      # by default a glob pattern that will include javascript files found in rails
      @include_pattern = "app/javascripts/**/*.js"

      # by default a glob pattern which will match no files
      @exclude_pattern = ""

      # by default use standard output for writing information
      @output_stream = STDOUT

      # if a block was given allow the block to call elements on this object
      yield self if block_given?

      # create the rake task
      new_task = task(name) do

        out = output_stream

        failed_files = runner.run do |file, errors|
          # print a * or . depending on if there were errors
          out.print errors.length > 0 ? "*" : "."

          # flush standard out since print doesn't seem to do so automatically
          out.flush
        end

        # print a summary of failed files
        if failed_files.any?
          out.print "\n\nFailures:\n\n"

          failed_files.each do |file, errors|
            out.print "#{file}:\n"
            errors.each do |error|
              out.print "   line #{error.line_number} character #{error.character} #{error.reason}\n"
            end
          end
        end

        # print a numerical summary
        error_count = failed_files.values.flatten.length

        out.print "\n" if failed_files.empty?

        out.print "\n#{ARGV.length} files, #{failed_files.length} failures, #{error_count} errors"

        # add a newline to be nice to the console
        out.print "\n"
      end
      
      # assign the description to the rake task
      new_task.comment = description
    end

    def files_to_run
      included_files = Dir.glob(include_pattern)
      excluded_files = Dir.glob(exclude_pattern)

      included_files - excluded_files
    end

  private
    
    def runner
      JSLintJohnson::Runner.new(files_to_run)
    end

  end
end