Feature: create friends feed
  As a non techy LiveJournalist
  I want a simple way to create friends feed
  So that I can subscribe to it and stay tuned with what my friends post

  Scenario: create feed
    Given there is a livejournal user
    When I create a feed for that user
    Then I should see that feed is created
    And I should be able to subscribe to it
