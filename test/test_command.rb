require 'helper'

class TestRunner < Test::Unit::TestCase
  context "creating a command" do
    should "create a command" do
      old_count = Subcheat::Command.commands.size
      Subcheat::Command.define('name') { puts 'foo' }
      assert_equal(old_count + 1, Subcheat::Command.commands.size)
    end
  end

  context 'finding commands' do
    should 'return a command for a name' do
      assert_instance_of(Subcheat::Command, Subcheat::Command.on('undo'))
    end

    should 'raise when loading non-exstant commands' do
      assert_raise(Subcheat::NoSuchCommand) { Subcheat::Command.on('foo') }
    end
  end
end