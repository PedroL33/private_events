class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:sessions][:username])
        if user
            login(user)
            flash[:success] = "Successfully logged in!"
            redirect_to user_path(user.id)
        else
            flash[:danger] = "Invalid username"
            render 'new'
        end
    end

    def destroy
        logout if logged_in?
        flash[:success] = "Successfully logged out."
        redirect_to root_url
    end 
end
