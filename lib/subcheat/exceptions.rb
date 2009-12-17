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
end