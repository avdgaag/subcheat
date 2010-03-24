require 'helper'

class TestTextCommand < Test::Unit::TestCase
  should 'print its command output' do
    assert_equal('foo', TextCommand.new(:test) { |svn| 'foo' }.run(nil))
  end

  should 'run its prerequisites before its subcommand'
end