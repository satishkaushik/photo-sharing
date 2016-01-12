class UsersController < ApplicationController
	
	def login
		@user = User.new
	end
	
	def create
		@user = User.where(user_params).first_or_initialize

		respond_to do |format|
			if @user.save
			  session[:user_id] = @user.id
			  format.html { redirect_to photos_path, notice: 'User logged in successfully.' }
			else
			  format.html { render :login }
			end	
		end
  	end
  
  private
  
  def user_params
    params.require(:user).permit(:username)
  end
end
