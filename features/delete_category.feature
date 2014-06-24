Feature: Delete a category
  As a blog administrator
  In order to categorise the articles in my blog
  I want to be able to add a new category

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Delete an existing category
    When I go to the categories page
    And I follow "Delete"
    And I press "delete"
    Then I should see "Categories"
    And I should not see "General"
