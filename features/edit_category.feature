Feature: Edit a category
  As a blog administrator
  In order to categorise the articles in my blog
  I want to be able to add a new category

  Background:
    Given the blog is set up
    And the following categories exist:
      | name     | permalink |
      | Recipes  | recipes   |
    And I am logged into the admin panel

  Scenario: Editing an existing category
    When I go to the categories page
    And I follow "Edit"
    And I fill in "category_name" with "New Changes"
    And I press "Save"
    Then I should see "New Changes"
    And I should not see "General"
