# Undo a commit or range of commits.
#
# This reverse-merges one or more revision into the current working copy.
#
#   > svn undo 45
#   > svn undo 45:50
#
# This will merge in 45:44 and 50:45 respectively. The source to merge from
# is the current working copy URL by default, but you may specify your own:
#
#   > svn undo 5034 ^/my-project/trunk
subcommand :undo do
  revision, url = arguments[0], arguments[1]
  revision = case revision
    when /^\d+$/: "#{revision}:#{revision.to_i - 1}"
    when /^\d+:\d+$/: revision.split(':').reverse.join(':')
    else
      raise Subcheat::CommandException, "Bad revision: #{revision}"
  end
  url ||= attr('URL')
  svn.merge('-r', revision, url)
end