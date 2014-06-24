# Add a declarative step for populating the DB with categories.
#
Given /the following categories exist/ do |categories_table|
  categories_table.hashes.each do |category|
    Category.create!(category)
  end
end
