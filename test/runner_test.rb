require 'test_helper'

describe Subcheat::Runner do
  before do
    Subcheat::Runner.output = StringIO.new
    Subcheat::Runner.perform_run = false
  end

  def subcheat_output
    Subcheat::Runner.output.string.chomp
  end

  describe 'No arguments' do
    it 'should run help by default' do
      Subcheat::Runner.new
      subcheat_output.must_equal 'svn help'
    end
  end

  describe 'unwrapped commands' do
    it 'should pass through commands' do
      Subcheat::Runner.new('status')
      subcheat_output.must_equal 'svn status'
    end

    it 'should pass through arguments' do
      Subcheat::Runner.new('status --ignore-externals')
      subcheat_output.must_equal 'svn status --ignore-externals'
    end
  end

  describe 'wrapped commands' do
    it 'should find and call associated command' do
      Subcheat::Command.expects(:on).with('undo').returns(stub(:call => 'foo'))
      Subcheat::Runner.new('undo', '55')
      subcheat_output.must_equal 'foo'
    end
  end
end
