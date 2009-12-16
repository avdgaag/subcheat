Before do
  Subcheat::Runner.output = StringIO.new
  Subcheat::Runner.class_eval do
    def run(command)
      self.class.write command
    end
  end
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
