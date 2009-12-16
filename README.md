# subcheat

Subcheat is a simple wrapper around Subversion's svn command-line client.

**This is hobby project I'm hacking away on. Poke around at your own peril.**

## Description

`subcheat` functions the same way svn does. You could alias `subcheat` to `svn` and use `subcheat` from now on without ever noticing it.

`subcheat` adds some subcommands that can make your life a little easier:

* `subcheat undo`: roll-back a commit or range of commits.
* `subcheat tag`: create, show or delete tags
* `subcheat branch`: create, show or delete branches
* `subcheat reintegrate`: merge changes from a branch back into trunk
* `subcheat rebase`: merge changes from trunk into current branch

Also, some existing subcommands are enhanced:

* `subcheat export`: now expands simple tag names to tag URLs
* `subcheat switch`: now expands simple branch names to branch URLs

## Assumptions

Subcheat assumes a particular layout for your repository:

    [root]
     `- project1
        `- trunk
        `- branches
        `- tags
     `- project2
        `- trunk
        `- branches
        `- tags
     `- ...

It might some day be made more flexible, but this works for me right now.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2009 Arjan van der Gaag. See LICENSE for details.
