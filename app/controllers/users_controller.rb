class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def index 
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @upcoming_events = @user.accepted.select("*").group("date").having("date > ?", Time.now)
        @past_events = @user.accepted.select("*").group("date").having("date < ?", Time.now)
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login(@user)
            flash[:success] = "Signed in as #{@user.username}"
            redirect_to root_url
        else
            flash.now[:danger] = "Invalid username or email"
            render 'new'
        end
    end

    private

        def user_params
            params.require(:user).permit(:username, :email)
        end
end
