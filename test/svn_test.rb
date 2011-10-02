require 'test_helper'

describe Subcheat::Svn do
  before do
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

  it 'should read attributes' do
    @svn.attr('URL').must_equal 'https://some-kind-of-svn.com/svn/project_name/branches/languages'
    @svn.attr('Revision').must_equal '8049'
  end

  it 'find project base URL' do
    @svn.base_url.must_equal 'https://some-kind-of-svn.com/svn/project_name/'
  end
end
