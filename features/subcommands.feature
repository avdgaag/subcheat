Feature: new subcheat subcommands
  In order to make working with subversion a little easier
  As a user
  I want to use simple commands for complex patterns

  Scenario: rolling back a commit
    Given a working copy with url: foo
    When I run "subcheat undo 50"
    Then subcheat should run "svn merge -r 50:49 foo"

  Scenario: rolling back a commit from a different URL
    Given a working copy with url: foo
    When I run "subcheat undo 50 bar"
    Then subcheat should run "svn merge -r 50:49 bar"

  Scenario: rolling back a range of commits
    Given a working copy with url: foo
    When I run "subcheat undo 50:60"
    Then subcheat should run "svn merge -r 60:50 foo"