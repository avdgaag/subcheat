module Svm
  class Runner

    attr_reader :args

    def initialize(*args)
      @args = args

      # Default to the help command is none is given.
      @args[0] ||= 'help'

      # See if there are any commands to execute.
      # The command return value, if any, tells us to continue
      # with SVN execution in +execute+ or not.
      if Commands.respond_to?(@args[0])
        @command_output = Commands.send(@args[0], @args)
      end
    end

    def self.execute(*args)
      new(*args).execute
    end

    # A string representation of the command to be executed
    def command
      "svn #{args.join(' ')}"
    end

    # Runs the target Subversion command
    def execute
      if @command_output =~ /^svn/
        puts @command_output
      elsif @command_output || @command_output.nil?
        puts 'svn', *args
      end
    end
  end
end