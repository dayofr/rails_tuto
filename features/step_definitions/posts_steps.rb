require 'coveralls'
Coveralls.wear!('rails')

Given(/^(?:|I )have the posts:$/) do |posts|
  posts.hashes.each do |post|
    Post.create!(:name => post[:name], :description => post[:description])
  end
end

When /^(?:|I )go to (.+)$/ do |page_name|
  case
    when 'the list of posts'
      visit url_for :controller => 'posts', :action => 'index'
  end
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Given(/^(?:|I )have no posts$/) do
  Post.delete_all
end

When(/^(?:|I )add posts:$/) do |posts|
  posts.hashes.each do |post|
    visit url_for :controller => 'posts', :action => 'new'
    fill_in 'post_name', :with => post[:name]
    fill_in 'post_description', :with => post[:description]
    click_button 'Create Post'
    step 'I should see "Post was successfully created."'
  end
end

Then /^(?:|I )should have ([0-9]+) post/ do |count|
  Post.count.should == count.to_i
end

When(/^(?:|I )update the title "(.*?)" to "(.*?)"$/) do |old, new|
  id = Post.where(name: old).first.id
  visit url_for :controller => 'posts', :action => 'edit', :id => id
  fill_in 'post_name', :with => new
  click_button 'Update Post'
  step 'I should see "Post was successfully updated."'
end

Then(/^(?:|I )should have a post "(.*?)"$/) do |name|
  assert Post.where(name: name).size == 1
end

Then(/^(?:|I )shouldn't have a post "(.*?)"$/) do |name|
  assert Post.where(name: name).size == 0
end