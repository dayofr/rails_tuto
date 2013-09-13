Feature: Manage posts
  In order to make a blog
  As an author
  I want to create and manage posts

  Scenario: Posts List
    Given I have posts titled Paris, Marseille
    When I go to the list of posts
    Then I should see "Paris"
    And I should see "Marseille"

  Scenario: Create Valid Post
    Given I have no posts
    When I add posts:
      | name  | description |
      | Dayo | Hello boy   |
    And I should see "Dayo"
    And I should see "Hello boy"
    And I should have 1 post

  Scenario: Create 2 Valid Post
    Given I have no posts
    When I add posts:
      | name | description |
      | Dayo | Hello boy    |
      | Blog | Bonjour le monde |
    And I should have 2 post