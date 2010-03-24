module Subcheat
  class TextCommand < Command
    def run(svn)
      run_prerequisites(svn)
      Subcheat.puts @method.call(svn)
    end
  end
end