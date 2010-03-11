# Merge changes from trunk into a branch.
#
#   > svn rebase
#
# This will merge all changes from trunk to the current working copy from its
# branch point to the HEAD revision. This will only work when you're inside a
# branch working copy.
#
# You can optionally specify the revision number to merge from:
#
#   > svn rebase 5032
#
# This will merge from 5032:HEAD.
subcommand :rebase do
  raise Subcheat::CommandException, 'You can only rebase a branch working copy.' unless attr('URL') =~ /branches/
  logs = log('.', '--stop-on-copy') unless arguments[0]
  if logs
    branch_point = logs.scan(/^r(\d+) \|/).flatten.last
  else
    raise Subcheat::CommandException, 'Could not calculate branch starting point. Please provide explicitly.' unless arguments[0]
  end
  svn.merge('-r', "#{(arguments[0] || branch_point)}:HEAD", "#{base_url}trunk", '.')
end

# Merge changes from a branch back into trunk.
#
#   > svn reintegrate FB-refactor
#
# This will merge all changes from /branches/FB-refactor from its starting point
# to the HEAD revision back into the current working copy. This is intended to be used
# inside a /trunk working copy.
#
# Optionally, you can specify the starting point of the merge, rather than using the
# branch starting point:
#
#   > svn reintegrate FB-refactor 5032
#
# This will merge in changes from the branch from range 5032:HEAD.
subcommand :reintegrate do
  branch_url = "#{base_url}branches/#{arguments[0]}"
  logs = log(branch_url, '--stop-on-copy') unless arguments[1]
  if logs
    branch_point = logs.scan(/^r(\d+) \|/).flatten.last
  else
    raise Subcheat::CommandException, 'Could not calculate branch starting point. Please provide explicitly.' unless arguments[1]
  end
  svn.merge('-r', "#{(arguments[1] || branch_point)}:HEAD", branch_url, ".")
end