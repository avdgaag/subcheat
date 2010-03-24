require 'helper'

class TextCommander < Test::Unit::TestCase
  should 'instantiate with subcommand'
  should 'parse arguments into subcommand and subcommand arguments'
  should 'default subcommand to help'
  should 'default subcommand arguments to none'
  should 'read all available subcommands on instantiation'
  should 'create a new subcommand'
  should 'create a new textcommand'
  should 'run matching subcommands'
end