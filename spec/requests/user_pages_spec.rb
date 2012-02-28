require 'spec_helper'

describe "UserPages" do
  subject { page }
  
  describe "GET /user_pages" do
    before { visit signup_path }
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
end
