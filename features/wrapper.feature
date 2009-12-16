Feature: invisibly wrap svn
  In order to transparently replace svn
  As a user
  I want to use normal svn commands

  Scenario: pass through commands
    Given a working copy
    When I run "subcheat update"
    Then subcheat should run "svn update"

 Scenario: pass through commands with arguments
   Given a working copy
   When I run "subcheat update . --force"
   Then subcheat should run "svn update . --force"

 Scenario: pass through default command
   Given a working copy
   When I run "subcheat"
   Then subcheat should run "svn help"