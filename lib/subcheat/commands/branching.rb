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
Subcheat::Command.define('rebase') do
  url = info[/URL: (.+?)$/, 1]
  raise 'You can only rebase a branch working copy.' unless url =~ /branches/
  logs = `svn log --stop-on-copy` unless arguments[0]
  if logs
    branch_point = logs.scan(/^r(\d+) \|/).flatten.last
  else
    raise 'Could not calculate branch starting point. Please provide explicitly.' unless arguments[0]
  end
  "svn merge -r #{(arguments[0] || branch_point)}:HEAD #{url.split('branches').first}trunk ."
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
Subcheat::Command.define('reintegrate') do
  # TODO: make sure to get the correct logs (not from current, which should be trunk)
  logs = `svn log --stop-on-copy` unless arguments[1]
  if logs
    branch_point = logs.scan(/^r(\d+) \|/).flatten.last
  else
    raise 'Could not calculate branch starting point. Please provide explicitly.' unless arguments[1]
  end
  "svn merge -r #{(arguments[1] || branch_point)}:HEAD #{info[/URL: (.+?)$/, 1].split('branches').first}branches/#{arguments[0]} ."
end