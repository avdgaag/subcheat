# Manage branches
#
#   > svn branch -l
#
# List all branches for the current project.
#
#   > svn branch -d FB-refactor
#
# Remove branch 'FB-refactor'
#
#   > svn branch FB-refactor
#
# Create branch 'FB-refactor'
Subcheat::Command.define('branch') do
  if delete = arguments.delete("-d")
    raise 'No URL to delete given.' unless arguments[0]
    "svn delete %sbranches/%s %s" % [
      attr('URL'),
      arguments[0],
      arguments[1..-1].join(' ')
    ]
  elsif list = arguments.delete('-l') || !arguments.any?
    "svn list #{base_url}branches/"
  else
    "svn copy %s %s %s" % [
      attr('URL'),
      base_url + "branches/#{arguments[0]}",
      arguments[1..-1].join(' ')
    ]
  end
end

# Manage tags
#
#   > svn tag -l
#
# List all tags for the current project.
#
#   > svn tag -d REL-1.0
#
# Remove tag 'REL-1.0'
#
#   > svn tag REL-1.0
#
# Create tag 'REL-1.0'
Subcheat::Command.define('tag') do
  if delete = arguments.delete("-d")
    raise 'No URL to delete given.' unless arguments[0]
    "svn delete %tags/%s %s" % [
      attr('URL'),
      arguments[0],
      arguments[1..-1].join(' ')
    ]
  elsif list = arguments.delete('-l') || !arguments.any?
    "svn list #{base_url}tags/"
  else
    "svn copy %s %s %s" % [
      attr('URL'),
      base_url + "tags/#{arguments[0]}",
      arguments[1..-1].join(' ')
    ]
  end
end