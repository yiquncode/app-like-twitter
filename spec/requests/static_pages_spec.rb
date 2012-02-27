require 'spec_helper'

describe "Static Pages" do
  
  describe "Home page" do
    it "should have the content 'Home'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      page.should have_selector('title',:text => " | Home")
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit about_path
      page.should have_content('About Us')
    end
  end
  
  describe "Contact page" do
    
    it "should have the h1 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('h1', text: 'Contact')
    end
    
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('title',
                    text: "Ruby on Rails Tutorial Sample App | Contact")
    end
  end
    
end
