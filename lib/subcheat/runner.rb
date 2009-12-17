require 'stringio'
module Subcheat
  class Runner

    # Arguments to the command line client
    attr_reader :args

    class << self
      # Usually $stdin, but might be overridden
      attr_accessor :output, :perform_run

      # Print something to the output stream
      def write(msg)
        self.output.puts(msg)
      end

      # Run a command in the system.
      def run(command)
        # (perform_run.nil? || perform_run) ? exec(command) : self.write(command)
        self.write(command)
      end
    end

    def initialize(*args)
      @args = args

      @svn = Svn.new

      # Default to $stdout
      self.class.output = $stdout if self.class.output.nil?

      subcommand, *arguments = args
      subcommand ||= 'help'
      arguments  ||= []

      if %w{version --version -v}.include?(subcommand)
        puts Subcheat::VERSION
      else
        begin
          self.class.run Command.on(subcommand).call(@svn, arguments)
        rescue Svn::NotAWorkingCopy
          # ...
        rescue Command::NoSuchCommand
          self.class.run "svn #{subcommand} #{arguments.join(' ')}".strip
        end
      end
    end
  end
end