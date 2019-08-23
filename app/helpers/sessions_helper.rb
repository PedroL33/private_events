module SessionsHelper

    def login(user)
        session[:user_id] = user.id
        @current_user = user
    end

    def current_user=(user)
        @current_user = user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil?
    end

    def logout
        session.delete :user_id
        @current_user = nil
    end

    def already_happened?(event)
        Event.past.include?(event)
    end

    def status(event)
        user = User.find(session[:user_id])
        if event.invited.include?(user)
            return "invited"
        elsif event.accepted.include?(user)
            return "accepted"
        elsif event.requested.include?(user)
            return "requested"
        else
            return "none"
        end
    end

    def creator?(event)
        User.find(session[:user_id]) == event.creator
    end

    def is_user?(user)
        user.id == session[:user_id]
    end

end
