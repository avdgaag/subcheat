# Require all subcheat components
%w{exceptions runner svn command}.each do |filename|
  require File.join(File.dirname(__FILE__), 'subcheat', filename)
end

module Subcheat
  autoload :VERSION, 'subcheat/version'
end
