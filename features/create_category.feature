Feature: Create category
  As a blog administrator
  In order to categorise the articles in my blog
  I want to be able to add a new category and edit an existing category

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Adding a new category
    When I go to the new category page
    Then I should see "Categories"
    And I should see the "Name" field
    And I should see the "Keywords" field
    And I should see the "Permalink" field
    And I should see the "Description" field
    And I should see the "Save" button
    And the "Name" field should be empty
    And the "Permalink" field should be empty

