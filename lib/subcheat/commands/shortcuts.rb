subcommand :uie do
  svn.update('--ignore-externals', *arguments)
end

# Enable exporting of tags
#
#   > svn export REL-1.0 ~/Desktop/export
#
# This will now export the 'REL-1.0' tag from the 'tags' directory of the repo.
# def export(args)
#   args[1] = project_root_url + '/tags/' + args[1] if args[1] =~ /^[a-zA-Z\-_0-9]+$/
# end
subcommand :export do
  if arguments[0] =~ /^[a-zA-Z\-_0-9]+$/
    svn.export(("%stags/%s" % [base_url, arguments.shift]), *arguments)
  end
end

# Enable switching to branch names.
#
#   > svn switch FB-refactor
#
# This will now switch the current working copy to the 'FB-refactor' branch.
subcommand :switch do
  if arguments[0] =~ /^[a-zA-Z\-_0-9]+$/
    svn.switch(("%stags/%s" % [base_url, arguments.shift]), *arguments)
  end
end