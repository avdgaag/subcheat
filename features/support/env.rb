$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'subcheat'
require 'mocha'
require 'test/unit/assertions'
World(Test::Unit::Assertions)