# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  #it is a good practice to define attr_accessible for every model.
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_secure_password
  before_save :create_remember_token
  
  
  validates :name, presence: true, length: { maximum: 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: valid_email_regex },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
        
  private
      def signed_in_user
        redirect_to signin_path, notice: "Please sign in." unless signed_in?
      end
      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end    
end
