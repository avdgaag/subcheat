require 'helper'

class TestCommand < Test::Unit::TestCase
  should 'instantiate'
  should 'not instantiate without a block or subcommand'
  should 'run its command'
  should 'run its prerequisites before its subcommand'
  should 'match other subcommands'
end