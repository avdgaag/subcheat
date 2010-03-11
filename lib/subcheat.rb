# Require all subcheat components
%w{exceptions runner svn command}.each do |filename|
  require File.join(File.dirname(__FILE__), 'subcheat', filename)
end

module Subcheat
  # General-purpose program-specific exception.
  Exception        = Class.new(Exception)

  # Raised when looking for a custom command that does not exist.
  NoSuchCommand    = Class.new(Exception)

  # Raised when trying to have subversion work on a directory
  # that is not a working copy.
  NotAWorkingCopy  = Class.new(Exception)

  # General-purpose exception that commands can raise to halt execution.
  CommandException = Class.new(Exception)

  # Report the version number from /VERSION
  def version
    File.read(File.join(File.dirname(__FILE__), *%w{.. VERSION}))
  end
  extend self
end