module Subcheat
  class Command
    attr_reader :subcommand
    attr_reader :prerequisites

    def initialize(subcommand, prerequisites = [], &block) #:nodoc:
      @subcommand, @prerequisites, @method = subcommand, prerequisites, block
    end

    def ===(other_subcommand)
      return subcommand === other_subcommand ? true : super
    end

    def run(svn)
      run_prerequisites
      system(@method.call(svn))
    end

  protected

    def run_prerequisites
      prerequisites.map { |c| c.run }
    end
  end
end