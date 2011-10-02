require 'test_helper'

class TestSubcheat < Test::Unit::TestCase
  should 'report version number' do
    File.expects(:read).returns('foo')
    assert_equal 'foo', Subcheat.version
  end
end
