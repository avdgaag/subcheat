Subcheat::Command.define('uie') do
  "svn update --ignore-externals #{arguments.join(' ')}"
end

# Check Out Project: shortcut to check out a working copy from the repository
#
#   > svn cop my-project
#
# This will checkout the ^/my-project/trunk folder to the my-project dir in
# the current directory. You may specify a specific branch or tags:
#
#   > svn cop my-project/tags/REL-1.0
#
# You may also specify the directory name to create the new working copy in:
#
#   > svn cop my-project new-dir
Subcheat::Command.define('cop') do
  raise 'NYI'
  url = 'http://repo/' + arguments[0]
  url += '/trunk' unless url =~ /trunk|tags|branches/
  dir = arguments[0].gsub(/^www\.|\.(?:nl|fr|be|com).*$/i, '')
  arguments.insert(1, dir) if (arguments[1] && arguments[1] =~ /^-+/) || arguments[1].nil?
  "svn checkout #{url} #{arguments[1..-1].join(' ')}"
end

# Print pretty formatted log output
Subcheat::Command.define('pretty-log') do
  %Q{svn log --stop-on-copy -q | grep -E "r[0-9]+" | tail -1 | sed 's/r\([0-9][0-9]*\).*/\1/'}
end

# Enable exporting of tags
#
#   > svn export REL-1.0 ~/Desktop/export
#
# This will now export the 'REL-1.0' tag from the 'tags' directory of the repo.
# def export(args)
#   args[1] = project_root_url + '/tags/' + args[1] if args[1] =~ /^[a-zA-Z\-_0-9]+$/
# end
Subcheat::Command.define('export') do
  if arguments[0] =~ /^[a-zA-Z\-_0-9]+$/
    "svn export %stags/%s %s" % [
      base_url,
      arguments[0],
      arguments[1..-1].join(' ')
    ]
  end
end

# Enable switching to branch names.
#
#   > svn switch FB-refactor
#
# This will now switch the current working copy to the 'FB-refactor' branch.
Subcheat::Command.define('switch') do
  if arguments[0] =~ /^[a-zA-Z\-_0-9]+$/
    "svn switch %sbranches/%s %s" % [
      base_url,
      arguments[0],
      arguments[1..-1].join(' ')
    ]
  end
end
