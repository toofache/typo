# Add a declarative step for populating the DB with categories.
#
Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create!(article)
  end
end
