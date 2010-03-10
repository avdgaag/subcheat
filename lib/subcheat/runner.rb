module Subcheat
  # the Runner handles this program's input and output, and selects and
  # invokes the commands to run.
  #
  # == Program flow
  #
  # 1. The user invokes subcheat via the command line: <tt>subcheat foo</tt>
  # 2. The CLI creates a new runner.
  # 3. The +Runner+ finds a custom Command by the name +foo+ and invokes it.
  # 4. The +Command+ returns a Subversion command to be executed.
  # 5. The +Runner+ executes the command and exits.
  #
  # If no custom command for the given subcommand name was found, it will
  # be passed along to +svn+ itself. This way, subcheat is a transparent
  # wrapper around +svn+.
  #
  # == Testing
  #
  # You can control where output is sent by overriding +output+, which
  # defaults to <tt>$stdin</tt>. You can also prevent the actual
  # execution of commands by setting +perform_run+ to +false+.
  class Runner
    class << self
      # Usually <tt>$stdin</tt>, but might be overridden
      attr_accessor :output

      # Switch that controls whether commands are executed in the system,
      # or simply sent to the output stream.
      attr_accessor :perform_run

      # Print something to the output stream
      def write(msg)
        self.output.puts(msg)
      end

      # Run a command in the system.
      # Setting +perform_run+ to +false+ will make it just output the command,
      # rather than executing it.
      def run(command)
        (perform_run.nil? || perform_run) ? exec(command) : self.write(command)
      end
    end

    # Create a new runner by passing it all the arguments that the
    # command-line client received.
    #
    # The first argument is the name of the subcommand, and defaults to
    # 'help'. The rest are arguments passed to the subcommand.
    #
    # Creating a new runner will immediately run the given subcommand.
    def initialize(*args)
      # Default to $stdout
      self.class.output = $stdout if self.class.output.nil?

      # Gather subcommand and arguments
      subcommand, *arguments = args
      subcommand ||= 'help'
      arguments  ||= []

      begin
        self.class.run Command.on(subcommand).call(Svn.new(arguments))
      rescue NotAWorkingCopy
        # ...
      rescue NoSuchCommand
        self.class.run "svn #{subcommand} #{arguments.join(' ')}".strip
      rescue CommandException
        puts $!
      end
    end
  end
end