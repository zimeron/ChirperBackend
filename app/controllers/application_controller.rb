class ApplicationController < ActionController::API
    skip_before_action :verify_authenticity_token

    include ActionController::Cookies
    include ActionController::RequestForgeryProtection

    protect_from_forgery with: :exception

    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        else
            @current_user = nil
        end
    end
end
