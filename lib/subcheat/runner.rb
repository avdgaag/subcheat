require 'stringio'
module Subcheat
  class Runner

    # Arguments to the command line client
    attr_reader :args

    class << self
      # Usually $stdin, but might be overridden
      attr_accessor :output

      # Shortcut method to create a new runner and
      # and execute a command
      def execute(*args)
        new(*args).execute
      end

      # Print something to the output stream
      def write(msg)
        self.output.puts(msg)
      end

      # Run a command in the system.
      def run(command)
        exec command
      end
    end

    def initialize(*args)
      @args = args

      # Default to $stdout
      self.class.output = $stdout if self.class.output.nil?

      # Default to the help command is none is given.
      @args[0] ||= 'help'

      # See if there are any commands to execute.
      # The command return value, if any, tells us to continue
      # with SVN execution in +execute+ or not.
      if Commands.respond_to?(@args[0])
        @command_output = Commands.send(@args[0], @args)
      end
    end

    # Runs the target Subversion command
    def execute
      if @command_output =~ /^svn/
        self.class.run @command_output
      elsif @command_output || @command_output.nil?
        self.class.run ['svn', *args].join(' ')
      end
    end
  end
end