Feature: get friend's feed
  As a LiveJournalist
  I want to be able to subscribe to my friends posts
  So that I get notified when they publish something

  Scenario: get friend's feed
    Given there is a feed for a user
    When I get it with feed reader
    Then it should show its contents
