require 'test_helper'

class TestRunner < Test::Unit::TestCase
  context 'No arguments' do
    setup do
      disable_running_of_commands
    end

    should 'run help by default' do
      Subcheat::Runner.new
      assert_equal('svn help', subcheat_output)
    end
  end

  context 'unwrapped commands' do
    setup do
      disable_running_of_commands
    end

    should 'pass through commands' do
      Subcheat::Runner.new('status')
      assert_equal('svn status', subcheat_output)
    end

    should 'pass through arguments' do
      Subcheat::Runner.new('status --ignore-externals')
      assert_equal('svn status --ignore-externals', subcheat_output)
    end
  end

  context 'wrapped commands' do
    setup do
      disable_running_of_commands
    end

    should 'find and call associated command' do
      Subcheat::Command.expects(:on).with('undo').returns(stub(:call => 'foo'))
      Subcheat::Runner.new('undo', '55')
      assert_equal('foo', subcheat_output)
    end
  end
end
