module Subcheat
  module Commands
    # TODO: extract into a configuration file or something
    REPO = 'https://mixe.flexvps.nl/svn/mixe'

    # Blank slate.
    instance_methods.each { |m| undef_method(m) unless m =~ /(^__|send|to\?$)/ }

    extend self

    # Print help instructions
    #--
    # TODO: add command-line documentation for Subcheat subcommands.
    def help(args)
      if args[1] == 'subcheat'
        puts help_text
        false
      end
    end

    # Output the current version of Subcheat on top of Subversion's version info.
    def version(args)
      puts "Subcheat version #{Subcheat::VERSION}"
    end
    alias_method '--version', :version

    # Enable switching to branch names.
    #
    #   > svn switch FB-refactor
    #
    # This will now switch the current working copy to the 'FB-refactor' branch.
    def switch(args)
      args[1] = project_root_url + '/branches/' + args[1] if args[1] =~ /^[a-zA-Z\-_0-9]+$/
    end

    # Enable exporting of tags
    #
    #   > svn export REL-1.0 ~/Desktop/export
    #
    # This will now export the 'REL-1.0' tag from the 'tags' directory of the repo.
    def export(args)
      args[1] = project_root_url + '/tags/' + args[1] if args[1] =~ /^[a-zA-Z\-_0-9]+$/
    end

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
    def rebase(args)
      raise 'You can only rebase a branch working copy.' unless get_url =~ /branches/
      logs = `svn log --stop-on-copy` unless args[1]
      if logs
        branch_point = logs.scan(/^r(\d+) \|/).flatten.last
      else
        raise 'Could not calculate branch starting point. Please provide explicitly.' unless args[1]
      end
      args[0] = 'merge'
      args[2] = "-r #{(args[1] || branch_point)}:HEAD"
      args[1] = project_root_url + '/trunk'
      args[3] = '.'
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
    def reintegrate(args)
      logs = `svn log --stop-on-copy` unless args[2]
      if logs
        branch_point = logs.scan(/^r(\d+) \|/).flatten.last
      else
        raise 'Could not calculate branch starting point. Please provide explicitly.' unless args[2]
      end
      args[0] = 'merge'
      args[1] = project_root_url + '/branches/' + args[1]
      args[2] = "-r #{(args[2] || branch_point)}:HEAD"
      args[3] = '.'
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
    def cop(args)
      args[0] = 'checkout'
      project_name = args[1]
      args[1] = REPO + "/" + project_name
      args[1] += '/trunk' unless project_name =~ /trunk|tags|branches/
      target_dir = project_name.gsub(/^www\.|\.(nl|fr|be|com).*$/i, '')
      if (args[2] && args[2] =~ /^--/) || args[2].nil?
        args.insert(2, target_dir)
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
    def tag(args)
      branching_and_tagging('tags', args)
    end

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
    def branch(args)
      branching_and_tagging('branches', args)
    end

    # update --no externals
    def une(args)
      args[0] = 'update'
      args << '--no-externals'
    end

    # Get the current revision number
    def revision(args)
      with_info { |info| puts info[/Revision: (\d+)/i, 1] }
      false
    end

    # Get the URL for the current working copy
    def url(args)
      puts get_url
      false
    end

    # Get the path inside the current repository for the current working copy
    def path(args)
      with_info { |info| puts info[/URL: #{REPO}(.+?)$/i,1] }
      false
    end

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
    def undo(args)
      revision, url = args[1], args[2]
      revision = case revision
        when /^\d+$/: "#{revision}:#{revision.to_i - 1}"
        when /^\d+:\d+$/: revision.split(':').reverse.join(':')
        else
          raise "Bad revision: #{revision}"
      end
      args[0] = 'merge'
      args[1] = "-r #{revision}"
      args[2] = (url || get_url)
    end

  private

    # Helper function to dry up +branch+ and +tag+
    def branching_and_tagging(name, args)
      if delete = args.delete("-d")
        raise 'No URL to delete given.' unless args[1]
        args[0] = 'delete'
        args[1] = project_root_url + "/#{name}/" + args[1]
      elsif list = args.delete('-l')
        args[0] = 'list'
        args[1] = project_root_url + "/#{name}"
      else
        new_name = args[1]
        args[0] = 'copy'
        args[1] = get_url
        args[2] = project_root_url + "/#{name}/" + new_name
      end
    end

    # Get the root URL for the current project -- that is, the URL
    # that contains /trunk, /branches and /tags
    def project_root_url
      get_url.split(/\/(trunk|branches|tags)\/?/).first
    end

    # Get the current working copy URL
    def get_url
      with_info { |info| info[/URL: (.+)$/i, 1] }
    end

    # Get the current working copy info and do something with it
    # if there is any at all.
    def with_info
      info = `svn info`
      yield info unless info.empty?
    end

    def help_text
      <<-EOS
usage: svn <subcommand> [options] [args]
Subversion command-line client for Mixe, version #{Subcheat::VERSION}

Available Subcheat-specific subcommands:
    branch
    tag
    rebase
    reintegrate
    undo
    url
    revision
    cop
    une
    path
      EOS
    end
  end
end