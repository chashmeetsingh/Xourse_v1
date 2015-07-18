class AuthController < ApplicationController

	before_action :confirmed_login, :except=>[:login,:signup,:login_attempt,:signup_attempt]

	def login
		@active = :login
		if !session[:user_id].nil?
			flash[:notice] = "Already Logged In !!"
			redirect_to('/index')
		end
	end

	def signup
		@active = :signup
		if !session[:user_id].nil?
			flash[:notice] = "Already Logged In !!"
			redirect_to('/index')
		end
	end

	def signup_attempt
	  	user = User.create(user_params)
	    
	  	if user.save
	      flash[:notice] = "Signed Up successfully !"
	      redirect_to(:action=>'login')
	  	else
	  		flash[:notice] = user.errors.full_messages
	  		redirect_to(:action=>'signup')
	  	end	 
	end

	def login_attempt
		user = User.find_by(:username=>params[:username])
		if user
			if user.password==params[:password] 
				flash[:notice] = "Logged In !!"
				session[:user_id] = user.id
				redirect_to(:action=>'dashboard')
			else
				flash[:notice] = "Invalid Credentials !!"
				render :login
			end
		else
			flash[:notice] = "User does not exist !!"
			render :login		
		end
	end

	def logout
	    session[:user_id]=nil
	  	flash[:notice]="You have successfully logged out"
	  	redirect_to(:action=>'login')
    end

    def dashboard
    	@courses = Course.all
    end

    def manage_pass
    end

    def change_pass
    	if params[:password]==params[:password1]
    		user=User.find(session[:user_id])
    		if user.update(:password=>params[:password])
    			flash[:notice]="Password Successfully Changed!!"
    		else
    			flash[:notice]="Password Not Changed"
    		end
    		redirect_to("/index")
    	else
    		flash[:notice]="Passwords do not match!!"
    		redirect_to("/auth/manage_pass")
    	end
    end

    def profile
    end

	private

	def user_params
		params.require(:user).permit(:username,:email,:password)
	end
end
