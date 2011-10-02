require 'test_helper'

class TestRunner < Test::Unit::TestCase
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
      @svn = Subcheat::Svn.new([])
      @svn.stubs(:info).returns(@info)
    end

    should "read attributes" do
      assert_equal('https://some-kind-of-svn.com/svn/project_name/branches/languages', @svn.attr('URL'))
      assert_equal('8049', @svn.attr('Revision'))
    end

    should 'find project base URL' do
      assert_equal('https://some-kind-of-svn.com/svn/project_name/', @svn.base_url)
    end
  end
end
