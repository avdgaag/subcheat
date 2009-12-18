module Subcheat

  # == Introduction
  # A command is a simple combination of a subcommand name and a proc object
  # that generates a subversion command. When invoking subcheat with a
  # subcommand the +Command+ object with by that name is looked up and executed
  # in the context of current directory (usually a working copy.)
  #
  # == Usage
  #
  # === Command Creation
  #
  # Commands are created with a special shorthand syntax:
  #
  #   Command.define('subcommand-name') do
  #     # do something useful here
  #   end
  #
  # Commands are then stored in the +Command+ class, which can be queried:
  #
  #   Command.on('subcommand-name')
  #
  # The returning subcommand can then be executed given a specific
  # Subversion context (an instance of <tt>Subcheat::Svn</tt>):
  #
  #   Command.on('subcommand-name').call(Svn.new)
  #
  # === Writing Commands
  #
  # Because commands get executed in a <ttr>Subcheat::SVN</tt> context, they
  # have access to all its methods and instance variables. See
  # <tt>Subcheat::SVN</tt> for more information.
  #
  # Note that a command should always return either a Subversion command
  # statement as a string (e.g. "svn status"). If it returns nothing,
  # nothing will be done.
  #
  # Commands can be stored in the <tt>lib/subcheat/commands</tt> directory,
  # so they will be automatically loaded together with this class. Filenames
  # are irrelevant.
  #
  # === Exceptions
  #
  # When something goes wrong, commands can raise a +CommandException+
  # exception. When querying Command for a non-existant subcommand a
  # +NoSuchCommand+ exception will be raised.
  class Command
    # Name of the subcommand to which this command should respond.
    attr_reader :subcommand

    # List of available commands that can be invoked.
    @commands = []

    class << self
      # List of all available commands
      attr_reader :commands

      #:call-seq: define(subcommand, &block)
      #
      # Shortcut method to creating and registering a new +Command+ object.
      #
      # This will instantiate a new +Command+ with the given subcommand name,
      # and the given block as its method to execute when invoked.
      #
      # Example usage:
      #
      #   Command.define('nuke') do
      #     exec "rm -Rf"
      #   end
      #
      def define(*args, &block)
        @commands << new(*args, &block)
      end

      # Query for a +Command+ object by the given subcommand name.
      #
      # This will return either a +Command+ object to be invoked, or it will
      # raise a +NoSuchCommand+ exception.
      def on(subcommand)
        command = @commands.select { |c| c.subcommand == subcommand }.first
        raise NoSuchCommand if command.nil?
        command
      end
    end

    def initialize(subcommand, &block) #:nodoc:
      @subcommand, @method = subcommand, block
    end

    # Invoke the +Command+'s method to generate and return a subversion CLI
    # statement.
    #
    # This requires an instance of <tt>Subcheat::Svn</tt> to be passed in,
    # which will be used as context to execute the method in.
    def call(svn)
      svn.instance_eval(&@method)
    end
  end
end

# Load command library from the /commands dir
Dir[File.join(File.dirname(__FILE__), 'commands', '*.rb')].each do |filename|
  require filename
end