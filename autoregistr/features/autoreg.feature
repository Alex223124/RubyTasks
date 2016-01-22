Feature: Automatic registration

  In order to crush the site
  A hacker
  Should be abble to make registration for 100 users

  Scenario: Automatic registration by hacker

    Given "100" attempts
    When hacker used them all
    Then emails and passwords for "100" users should be in file.csv