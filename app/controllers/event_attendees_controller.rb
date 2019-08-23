class EventAttendeesController < ApplicationController

    def new
        user = User.find(session[:user_id])
        @events = user.events.select("*").group("date").having("date > ?", Time.now)
        @attendee = EventAttendee.new
    end

    def create
        event_attendee = EventAttendee.new(attendee_params)
        if event_attendee.save
            flash[:success] = "Successfully attended event."
            redirect_to event_path(params[:event_attendee][:event_id])
        else
            attendee = EventAttendee.find_by(find_params)
            attendee.status = params[:event_attendee][:status]
            if attendee.save
                flash[:success] = "Successfully #{params[:event_attendee][:status]}"
                redirect_to event_path(params[:event_attendee][:event_id])
            else
                flash[:danger] = "An error occurred."
                redirect_to event_path(params[:event_attendee][:event_id])
            end
        end
    end

    def destroy
    end

    private

        def attendee_params
            params.require(:event_attendee).permit(:event_id, :user_id, :status)
        end

        def find_params
            params.require(:event_attendee).permit(:event_id, :user_id)
        end

end
