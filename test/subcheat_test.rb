require 'test_helper'

describe Subcheat do
  it 'should report version number' do
    Subcheat::VERSION.must_be_instance_of String
  end
end
