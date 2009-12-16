Before do
  Subcheat::Runner.output = StringIO.new
  Subcheat::Runner.perform_run = false
end

Given /^the subcommand "([^\"]*)"$/ do |subcommand|
  @subcommand = subcommand
end

Given /^the arguments? "([^\"]*)"$/ do |argument|
  (@args ||= []) << argument
end

When /^I run svn$/ do
  Subcheat::Runner.execute(*[@subcommand, *@args])
end

Then /^subcheat should run "([^\"]*)"$/ do |command|
  assert_equal command, Subcheat::Runner.output.string.gsub(/\s*$/, '')
end
