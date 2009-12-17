module Subcheat
  class Svn

    NotAWorkingCopy = Class.new(Exception)

    attr_accessor :arguments

    module Cli
      def info
        svn('info')
      end

    private

      def svn(subcommand)
        output = `svn #{subcommand}`
        raise NotAWorkingCopy if output.empty?
        output
      end
    end

    include Cli
  end
end