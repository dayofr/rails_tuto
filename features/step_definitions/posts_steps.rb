Given /^I have posts titled (.+)$/ do |names|
  names.split(', ').each do |name|
    Post.create!(:name => name)
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

Given(/^I have no posts$/) do
  Post.delete_all
end

When(/^I add posts:$/) do |posts|
  posts.hashes.each do |post|
    visit url_for :controller => 'posts', :action => 'new'
    fill_in 'post_name', :with => post[:name]
    fill_in 'post_description', :with => post[:description]
    click_button 'Create Post'
    step 'I should see "Post was successfully created."'
  end
end

Then /^I should have ([0-9]+) post/ do |count|
  Post.count.should == count.to_i
end