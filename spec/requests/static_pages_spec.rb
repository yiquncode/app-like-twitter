require 'spec_helper'

describe "Static Pages" do
  
  subject { page }
  
  shared_examples_for "all static page" do
    it { should have_selector('h1',text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end
  
  it "should have the right links on the layout" do
      visit root_path
      click_link "Home"
      page.should have_selector 'title', text: full_title('Home')
    end
  
  describe "Home page" do
    before { visit root_path }    
    let(:heading) {"Sample App"}
    let(:page_title) { 'Home' }
    
    it_should_behave_like "all static page"
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
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
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end
    
    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title',
                    text: "Ruby on Rails Tutorial Sample App | Contact")
    end
  end
    
end
