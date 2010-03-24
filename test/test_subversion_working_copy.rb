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
      File.stubs(:directory?).returns(true)
      @svn = Subcheat::SubversionWorkingCopy.new('foo')
    end

    should 'read working copy attributes' do
      @svn.stubs(:info).returns(@info)
      assert_equal('8049', @svn.attr('Revision'))
    end

    should 'read the working copy base url' do
      @svn.stubs(:info).returns(@info)
      assert_equal('https://some-kind-of-svn.com/svn/project_name/', @svn.base_url)
    end

    should 'call subversion commands' do
      %w{export switch update}.each do |sc|
        assert @svn.respond_to?(sc.to_sym), "Expected to respond to #{sc}"
      end
    end

    should 'cache results of svn info' do
      @svn.expects(:`).once.with('svn info foo').returns('foo')
      assert_equal('foo', @svn.info)
      assert_equal('foo', @svn.info)
    end

    should 'instantiate with a working copy' do
      File.expects(:directory?).returns(true)
      assert_not_nil(Subcheat::SubversionWorkingCopy.new('foo'))
    end

    should 'not instantiate without a working copy' do
      File.expects(:directory?).returns(false)
      assert_raise(Subcheat::NotAWorkingCopy) do
        Subcheat::SubversionWorkingCopy.new('foo')
      end
    end
  end
end