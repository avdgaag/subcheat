require 'helper'

class TestSubversionWorkingCopy < Test::Unit::TestCase
  context 'a working copy' do
    setup do
      @info = <<-EOS
Path: .
URL: https://some-kind-of-svn.com/svn/project_name/branches/languages
Repository Root: https://some-kind-of-svn.com/svn
Repository UUID: 11af7ba9-5ee7-4c51-9542-47637e3bfceb
Revision: 8049
Node Kind: directory
Schedule: normal
Last Changed Author: Andy
Last Changed Rev: 5019
Last Changed Date: 2009-12-11 15:12:57 +0100 (vr, 11 dec 2009)

EOS
      # @svn = Subcheat::SubversionWorkingCopy.new(Dir.pwd)
      # @svn.stubs(:info).returns(@info)
    end

    should 'read working copy attributes'
    should 'call subversion commands'
    should 'check if given directory is a working copy'

    should 'instantiate with a working copy' do
      File.expects(:directory?).with('foo/.svn').returns(true)
      assert_not_nil(Subcheat::SubversionWorkingCopy.new('foo'))
    end

    should 'not instantiate without a working copy'
  end
end