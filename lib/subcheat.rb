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
      commander = Commander.new(args)
      commander.run(SubversionWorkingCopy.new(Dir.pwd))
    rescue NotAWorkingCopy
      Subcheat.puts 'This is not a valid working copy.'
      exit 1
    rescue NoSuchCommand
      exec 'svn', commander.subcommand_name.to_s, *commander.arguments
    rescue CommandException
      Subcheat.puts $!
      exit 1
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