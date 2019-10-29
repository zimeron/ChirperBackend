class UsersController < ApplicationController
    def create
        puts "Trying to Create New user"
        puts user_params
        @user = User.new(user_params)        
        if @user.save
            puts "User successfully created"
            head 200, content_type: "text/json"
        else
            puts "Something went wrong while creating new User"
            puts(@user.errors.full_messages)
            head 500, content_type: "text/json"
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
