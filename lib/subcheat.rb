# Require all subcheat components
%w{exceptions runner svn command}.each do |filename|
  require File.join(File.dirname(__FILE__), 'subcheat', filename)
end

# Read the version info from file
File.open(File.join(File.dirname(__FILE__), '..', 'VERSION'), 'r') do |file|
   Subcheat::VERSION = file.read.gsub(/\s/, '')
end