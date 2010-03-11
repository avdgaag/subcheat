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
subcommand :branch do |opts|
  opts.banner = "Usage: subcheat branch [options] [branch_name]"
  opts.on('-d', '--delete BRANCH_NAME', 'Delete a branch') do |branch|
    svn.delete('%branches/%s' % [attr('URL'), branch], *arguments)
  end
  opts.on('-l', '--list', 'List branches') do
    svn.list("#{base_url}branches/")
  end
  opts.on('-c', '--create BRANCH_NAME', 'Create new branch') do |branch|
    svn.copy(attr('URL'), "#{base_url}branches/#{branch}", *arguments)
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
subcommand :tag do |opts|
  opts.banner = "Usage: subcheat tag [options] [tag_name]"
  opts.on('-d', '--delete TAG_NAME', 'Delete a tag') do |tag|
    svn.delete('%tags/%s' % [attr('URL'), tag], *arguments)
  end
  opts.on('-l', '--list', 'List tags') do
    svn.list("#{base_url}tags/")
  end
  opts.on('-c', '--create TAG_NAME', 'Create new tag') do |tag|
    svn.copy(attr('URL'), "#{base_url}tags/#{tag}", *arguments)
  end
end