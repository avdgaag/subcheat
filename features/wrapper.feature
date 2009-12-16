Feature: invisibly wrap svn
  In order to transparently replace svn
  As a user
  I want to use normal svn commands

  Scenario: pass through commands
    Given the subcommand "update"
    When I run svn
    Then subcheat should run "svn update"

 Scenario: pass through commands with arguments
   Given the subcommand "update"
   And the arguments ". --force"
   When I run svn
   Then subcheat should run "svn update . --force"