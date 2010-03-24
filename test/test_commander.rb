require 'helper'

class TextCommander < Test::Unit::TestCase
  should 'instantiate with subcommand' do
    assert_not_nil(Subcheat::Commander.new(:test))
  end

  should 'parse arguments into subcommand and subcommand arguments' do
    commander = Subcheat::Commander.new(*%w{subcommand arg1 arg2})
    assert_equal('subcommand', commander.subcommand_name)
    assert_equal(['arg1', 'arg2'], commander.arguments)
  end

  should 'default subcommand to help' do
    assert_equal('help', Subcheat::Commander.new.subcommand_name)
  end

  should 'default subcommand arguments to none' do
    assert_equal([], Subcheat::Commander.new.arguments)
  end

  should 'create a new subcommand' do
    commander = Subcheat::Commander.new
    assert_equal(0, commander.commands.size)
    commander.send(:subcommand, :test)
    assert_equal(1, commander.commands.size)
  end

  should 'create a new textcommand' do
    commander = Subcheat::Commander.new
    assert_equal(0, commander.commands.size)
    commander.send(:textcommand, :test)
    assert_equal(1, commander.commands.size)
  end

  should 'run matching subcommands' do
    has_run = false
    commander = Subcheat::Commander.new(:test)
    commander.send(:textcommand, :test) { has_run = true }
    commander.run(nil)
    assert has_run
  end
end