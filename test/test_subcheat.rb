require 'helper'

class TestSubcheat < Test::Unit::TestCase
  should 'report version number' do
    File.expects(:read).returns('foo')
    assert_equal 'foo', Subcheat.version
  end

  should 'print errors to stdout when an exception is raised'
  should 'report an error when trying to work on a non-working copy'
  should 'fall back to Subversion when a given command does not exist'
end