class ApplicationController < ActionController::API

    # Authorization cookie and session management
    include ActionController::Cookies


    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        else
            @current_user = nil
        end
    end
end
