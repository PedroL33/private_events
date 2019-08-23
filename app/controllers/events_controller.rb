class EventsController < ApplicationController

    def new
        @event = Event.new
    end

    def show
        @event = Event.find(params[:id])
        @status = status(@event)
    end

    def create
        user = User.find(session[:user_id])
        event = user.events.build(event_params)
        if event.save
            flash[:success] = "Event created!"
            redirect_to user_path(user.id)
        else 
            flash[:danger] = "Event could not be created."
            render 'new'
        end
    end

    def index
        @past = Event.past
        @upcoming = Event.upcoming
    end

    private

        def event_params
            params.require(:event).permit(:date, :title, :user_id)
        end
end
