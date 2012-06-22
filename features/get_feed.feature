Feature: subscribe to friends feed
  As a LiveJournalist
  I want to be able to subscribe to my friends posts
  So that I get notified when they publish something

  Scenario: subscribe to my friends feed
    Given there is a feed for my lj user
    When I subscribe to that feed
    Then I should see my friends posts
