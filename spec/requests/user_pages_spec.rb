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
    
  describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      before { visit edit_user_path(user) }

      describe "page" do
        it { should have_selector('h1',    text: "Edit user") }
        it { should have_selector('title', text: "Edit user") }
        it { should have_link('change', href: 'http://gravatar.com/emails') }
      end
      
      describe "with valid information" do
         let(:user)      { FactoryGirl.create(:user) }
         let(:new_name)  { "New Name" }
         let(:new_email) { "new@example.com" }
         before do
           fill_in "Name",         with: new_name
           fill_in "Email",        with: new_email
           fill_in "Password",     with: user.password
           fill_in "Confirmation", with: user.password
           click_button "Update"
         end
         it { should have_selector('title', text: new_name) }
         it { should have_selector('div.flash.success') }
         it { should have_link('Sign out', :href => signout_path) }
         
         #This code reloads the user variable from the test database using user.reload, 
         #and then verifies that the user’s new name and email match the new values.
         specify { user.reload.name.should  == new_name }
         specify { user.reload.email.should == new_email }
      end
       
      describe "with invalid information" do
        let(:error) { '1 error prohibited this user from being saved' }
        before { click_button "Update" }

        it { should have_content(error) }
     end
    end 
end
