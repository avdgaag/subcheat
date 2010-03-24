require 'helper'

class TestTextCommand < Test::Unit::TestCase
  should 'print its command output' do
    def Subcheat.puts(msg)
      msg
    end
    assert_equal('foo', Subcheat::TextCommand.new(:test) { |svn| 'foo' }.run(nil))
  end

  should 'run its prerequisites before its subcommand' do
    has_run = false
    command2 = Subcheat::Command.new(:test) { |svn| has_run = true }
    command1 = Subcheat::TextCommand.new(:test, [command2]) { |svn| 'foo' }
    Subcheat::Command.any_instance.stubs(:system).returns('bar')
    assert_equal('foo', command1.run(nil))
    assert has_run
  end
end