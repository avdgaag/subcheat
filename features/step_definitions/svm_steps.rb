Before do
  Svm::Runner.output = StringIO.new
  Svm::Runner.class_eval do
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
  Svm::Runner.execute(*[@subcommand, *@args])
end

Then /^svm should run "([^\"]*)"$/ do |command|
  assert_equal command, Svm::Runner.output.string.gsub(/\s*$/, '')
end
