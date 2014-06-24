Feature: Create category
  As a blog administrator
  In order to categorise the articles in my blog
  I want to be able to add a new category

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Adding a new category
    When I go to the categories page
    And I fill in "category_name" with "Recipes"
    And I fill in "category_permalink" with "recipes"
    And I press "Save"
    Then I should be on the categories page
    And I should see "Recipes"
