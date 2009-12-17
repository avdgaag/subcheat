module Subcheat
  class Command
    attr_reader :subcommand, :arguments, :svn

    NoSuchCommand = Class.new(Exception)

    @commands = []

    class << self
      def define(*args, &block)
        @commands << new(*args, &block)
      end

      def on(subcommand)
        command = @commands.select { |c| c.subcommand == subcommand }.first
        raise NoSuchCommand if command.nil?
        command
      end
    end

    def initialize(subcommand, &block)
      @subcommand, @method = subcommand, block
    end

    def call(svn, arguments)
      svn.arguments = arguments
      svn.instance_eval(&@method)
    end
  end
end

# Load command library from the /commands dir
Dir[File.join(File.dirname(__FILE__), 'commands', '*.rb')].each do |filename|
  require filename
end