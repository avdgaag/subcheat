if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end
require 'minitest/autorun'
require 'mocha'
require 'subcheat'
