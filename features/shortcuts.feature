Feature: Subversion shortcuts
  In order to speed up development
  As a user
  I want to enter common subversion commands quicker

  Scenario: updating without externals
    Given a working copy
    When I run "subcheat uie"
    Then subcheat should run "svn update --ignore-externals"

  Scenario: get common working copy information
    Given a working copy with attribute Revision: 54
    When I run "subcheat revision"
    Then subcheat should output "54"