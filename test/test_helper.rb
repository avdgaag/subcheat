require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'subcheat'

class Test::Unit::TestCase
  def disable_running_of_commands
    Subcheat::Runner.output = StringIO.new
    Subcheat::Runner.perform_run = false
  end

  def subcheat_output
    Subcheat::Runner.output.string.chomp
  end
end