Feature: Merge Articles
  As a blog administrator
  I want to be able to merge articles in my blog

  Background:
    Given the blog is set up
    And the following articles exist:
      | id | title     | body                |
      | 11 | Article 1 | This is article one |
      | 12 | Article 2 | This is article two |

  Scenario: An admin can successfully merge articles
    When I am logged into the admin panel
    And I am on the "Manage articles" page
    And I follow "Edit"
    And I fill in "merge_with" with "12"
    And I press "Merge"
    Then I should be on new article page
    And the "article_title" field should contain "Article 1"
    And I should see "This is article one"
    And I should see "This is article two"

  Scenario: A non-admin cannot merge articles
    When I am on the "Manage articles" page
    Then I should not see "Edit"
