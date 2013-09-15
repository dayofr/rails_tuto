Feature: Manage posts
  In order to make a blog
  As an author
  I want to create and manage posts

  Scenario: Posts List
    Given I have the posts:
      | name      | description |
      | Paris     | Hello boy   |
      | Marseille | Hello boy   |
    When I go to the list of posts
    Then I should see "Paris"
    And I should see "Marseille"

  Scenario: Create Valid Post
    Given I have no posts
    When I add posts with success:
      | name  | description |
      | Dayo | Hello boy   |
    Then I should see "Dayo"
    And I should see "Hello boy"
    And I should have 1 post

  Scenario: Create 2 Valid Post
    Given I have no posts
    When I add posts with success:
      | name | description |
      | Dayo | Hello boy    |
      | Blog | Bonjour le monde |
    Then I should have 2 post

  Scenario: Create Invalid Post
    Given I have no posts
    When I add posts with failure:
      | name  | description |
      |       | Hello boy   |
    Then I should see "Name can't be blank"
    And I should have 0 post

  Scenario: Update a Valid Post
    Given I have the posts:
      | name  | description |
      | Dayo | Hello boy   |
    When I update the title "Dayo" to "Hello" with success
    Then I shouldn't have a post "Dayo"
    And I should have a post "Hello"
    And I should have 1 post

  Scenario: Update an Invalid Post
    Given I have the posts:
      | name  | description |
      | Dayo | Hello boy   |
    When I update the title "Dayo" to "" with failure
    Then I should see "Name can't be blank"
    And I should have a post "Dayo"
    And I should have 1 post