require 'helper'

class TestCommand < Test::Unit::TestCase
  should 'instantiate' do
    assert_not_nil(Subcheat::Command.new(:subcommand))
  end

  should 'not instantiate without a block or subcommand' do
    assert_raise(ArgumentError) { Subcheat::Command.new }
  end

  should 'run its command' do
    has_run = false
    Subcheat::Command.any_instance.stubs(:system).returns('foo')
    assert_equal('foo', Subcheat::Command.new(:test) { |svn| has_run = true }.run(nil))
    assert has_run
  end

  should 'run its prerequisites before its subcommand' do
    has_run = false
    command2 = Subcheat::Command.new(:test) { |svn| has_run = true }
    command1 = Subcheat::Command.new(:test, [command2]) { |svn| 'foo' }
    Subcheat::Command.any_instance.stubs(:system).returns('foo')
    assert_equal('foo', command1.run(nil))
    assert has_run
  end

  should 'match subcommand name' do
    assert Subcheat::Command.new(:subcommand) === :subcommand
    assert !(Subcheat::Command.new(:subcommand) === :foo)
  end
end