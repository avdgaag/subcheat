require 'helper'

def Subcheat.puts(msg)
  msg
end

class TestSubcheat < Test::Unit::TestCase
  should 'report version number' do
    File.expects(:read).returns('foo')
    assert_equal 'foo', Subcheat.version
  end

  should 'report an error when trying to work on a non-working copy' do
    File.stubs(:directory?).returns(false)
    Subcheat.expects(:exit).with(1)
    Subcheat.run(:foo)
  end

  should 'fall back to Subversion when a given command does not exist' do
    File.stubs(:directory?).returns(true)
    c = Subcheat::Commander.new(:foo)
    c.expects(:run).raises(Subcheat::NoSuchCommand)
    Subcheat::Commander.expects(:new).returns(c)
    Subcheat.expects(:exec).with('svn', 'foo').returns('bar')
    assert_equal('bar', Subcheat.run(:foo))
  end

end