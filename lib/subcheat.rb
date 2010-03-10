# Require all subcheat components
%w{exceptions runner svn command}.each do |filename|
  require File.join(File.dirname(__FILE__), 'subcheat', filename)
end

module Subcheat
  # Report the version number from /VERSION
  def version
    File.read(File.join(File.dirname(__FILE__), *%w{.. VERSION}))
  end
  extend self
end