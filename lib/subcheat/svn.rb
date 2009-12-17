module Subcheat
  class Svn

    NotAWorkingCopy = Class.new(Exception)

    attr_accessor :arguments

    def initialize(arguments)
      @arguments = arguments
    end

    # Shortcut method to the base url for the current project in the current repo.
    def base_url
      attr('URL').split(/branches|tags|trunk/).first
    end

    module Cli
      def attr(name)
        info[/^#{name}: (.+?)$/, 1]
      end

      def log(repo, *arguments)
        svn("log #{repo} #{[*arguments].join(' ')}")
      end

      def info
        @info ||= svn('info')
      end

    private

      def svn(subcommand)
        output = `svn #{subcommand}`
        raise NotAWorkingCopy if output.empty?
        output
      end
    end

    # other modules may implement other ways of working with subversion
    # (like using the ruby bindings) but we choose the command-line client.
    include Cli
  end
end