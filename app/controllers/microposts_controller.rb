class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []  #巧妙的办法，如果没有值就传一个空的
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
  private

    def correct_user
      #In this case, we use find_by_id instead of find because the latter raises an exception 
      #when the micropost doesn’t exist instead of returning nil. 
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end