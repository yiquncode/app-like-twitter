require 'spec_helper'

describe "UserPages" do
  subject { page }
  
  describe "GET /user_pages" do
    before { visit signup_path }
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
  
  describe "profile page" do
    # Code to make a user variable
    before { visit users_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "signup" do #Listing 7.15. http://ruby.railstutorial.org/chapters/sign-up?version=3.2#fnref:7.7

      before { visit signup_path }
      
      #检查返回错误
      describe "error messages" do
        before { click_button "Sign up" }

        let(:error) { 'errors prohibited this user from being saved' }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content(error) }
      end

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button "Sign up" }.not_to change(User, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button "Sign up" }.to change(User, :count).by(1)
        end
        
        describe "after saving the user" do #检查flash
          before { click_button "Sign up" }
          let(:user) { User.find_by_email('user@example.com') }

          it { should have_selector('title', text: user.name) }
          it { should have_selector('div.flash.success', text: 'Welcome') }
          it { should have_link('Sign out') }
        end
      end
    end
  
end
