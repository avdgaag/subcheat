Before do
  Subcheat::Runner.output = StringIO.new
  Subcheat::Runner.perform_run = false
end

Given /^a working copy$/ do
  @wc ||= {}
end

Given /^(?:a working copy )?with attribute ([^:]+?): (.+?)$/ do |attribute, value|
  Subcheat::Svn.any_instance.expects(:attr).with(attribute).returns(value)
end

When /^I run "subcheat([^\"]*)"$/ do |arguments|
  Subcheat::Runner.new(*arguments.strip.split(/\s+/))
end

Then /^subcheat should run "([^\"]*)"$/ do |command|
  assert_equal command, Subcheat::Runner.output.string.gsub(/\s*$/, '')
end

Then /^subcheat should output "([^\"]*)"$/ do |output|
  assert_match(/#{output}/, Subcheat::Runner.output.string)
end