module Subcheat
  class Svn

    # The arguments passed to the subcommand
    attr_accessor :arguments

    def initialize(arguments)
      @arguments = arguments
    end

    # Shortcut method to the base url for the current project in the current repo.
    def base_url
      attr('URL').split(/branches|tags|trunk/).first
    end

    # Interact with Subversion through the command-line interface +svn+.
    module Cli
      # Extract a working copy attribute, like URL or revision number.
      def attr(name)
        info[/^#{name}: (.+?)$/, 1]
      end

      # Read the Subversion logs for a given path.
      def log(repo, *arguments)
        svn("log #{repo} #{[*arguments].join(' ')}")
      end

      # Retrieve information about the working copy.
      def info
        @info ||= svn('info')
      end

    private

      # Execute a subversion command in the shell, or raise an exception if
      # the target path is not actually a subversion working copy.
      #--
      # TODO: make this customizable, since users might sometimes ask for
      #       information about other paths than the current path.
      def svn(subcommand)
        output = `svn #{subcommand}`
        raise Subcheat::NotAWorkingCopy if output.empty?
        output
      end
    end

    # other modules may implement other ways of working with subversion
    # (like using the ruby bindings) but we choose the command-line client.
    include Cli
  end
end