module Subcheat
  class Commander
    attr_reader :subcommand
    attr_reader :arguments
    attr_reader :commands

    def initialize(*arguments)
      @subcommand, *@arguments = arguments
      @subcommand ||= 'help'
      @arguments  ||= []
      @commands = []
      read_commands
    end

    def run(subversion_working_copy)
      commands.each do |command|
        command.run(subversion_working_copy) if command === subcommand
      end
    end

  private

    def read_commands
      Dir['commands/*.rb'].each do |filename|
        instance_eval(File.read(filename))
      end
    end

    def textcommand(subcommand_name, &block)
      subcommand, prerequisites = extract_name_and_prerequisites(subcommand_name)
      @commands << TextCommand.new(subcommand, prerequisites, block)
    end

    def subcommand(subcommand_name, &block)
      subcommand, prerequisites = extract_name_and_prerequisites(subcommand_name)
      @commands << Command.new(subcommand, prerequisites, block)
    end

    # Take either <tt>:a</tt> or <tt>{ :a => [:b, :c] }</tt> and return
    # <tt>:a</tt> and <tt>[:b, :c]</tt> if present.
    def extract_name_and_prerequisites(subcommand_name)
      return subcommand_name unless subcommand_name.is_a?(Hash)
      return [subcommand_name.keys.first, subcommand_name[subcommand_name.keys.first]]
    end
  end
end