require File.join(File.dirname(__FILE__), *%w{subcheat commands})
require File.join(File.dirname(__FILE__), *%w{subcheat runner})

File.open(File.join(File.dirname(__FILE__), '..', 'VERSION'), 'r') do |file|
   Subcheat::VERSION = file.read.gsub(/\s/, '')
end