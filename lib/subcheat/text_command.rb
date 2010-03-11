module Subcheat
  class TextCommand < Command
    def run(svn)
      run_prerequisites
      Subcheat.puts command.call(svn)
    end
  end
end