# Require all subcheat components
%w{subversion_working_copy command text_command commander}.each do |filename|
  require File.join(File.dirname(__FILE__), 'subcheat', filename)
end

module Subcheat
  Exception        = Class.new(Exception)
  NoSuchCommand    = Class.new(Exception)
  NotAWorkingCopy  = Class.new(Exception)
  CommandException = Class.new(Exception)

  # Syntactic sugar
  def run(*args)
    begin
      Commander.new(args).run(SubversionWorkingCopy.new(Dir.pwd))
    rescue NotAWorkingCopy
      Subcheat.puts 'This is not a valid working copy.'
    rescue NoSuchCommand
      exec 'svn', subcommand, arguments
    rescue CommandException
      Subcheat.puts $!
    end
  end

  # Report the version number from /VERSION
  def version
    File.read(File.join(File.dirname(__FILE__), *%w{.. VERSION}))
  end

  # Central location for outputting stuff, so it can be mocked 'n stuff
  def puts(*args)
    STDOUT.puts *args
  end

  # Syntactic sugar
  extend self
end