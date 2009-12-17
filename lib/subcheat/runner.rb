module Subcheat
  class Runner

    class << self
      # Usually $stdin, but might be overridden
      attr_accessor :output, :perform_run

      # Print something to the output stream
      def write(msg)
        self.output.puts(msg)
      end

      # Run a command in the system.
      # Setting +perform_run+ to false will make it just output the command,
      # rather than executing it.
      def run(command)
        (perform_run.nil? || perform_run) ? exec(command) : self.write(command)
      end
    end

    def initialize(*args)
      # Default to $stdout
      self.class.output = $stdout if self.class.output.nil?

      # Gather subcommand and arguments
      subcommand, *arguments = args
      subcommand ||= 'help'
      arguments  ||= []

      if %w{version --version -v}.include?(subcommand)
        puts Subcheat::VERSION
      else
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
end