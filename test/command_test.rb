require 'test_helper'

describe Subcheat::Command do
  it 'should create a command' do
    old_count = Subcheat::Command.commands.size
    Subcheat::Command.define('name') { puts 'foo' }
    Subcheat::Command.commands.size.must_equal old_count + 1
  end

  it 'should find a command by name' do
    Subcheat::Command.on('undo').must_be_instance_of Subcheat::Command
  end

  it 'should raise when loading non-exstant commands' do
    lambda { Subcheat::Command.on('foo') }.must_raise(Subcheat::NoSuchCommand)
  end
end
