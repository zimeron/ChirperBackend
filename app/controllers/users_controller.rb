class UsersController < ApplicationController
    def user_params
        params_require(:current_user).permit(:id, :username, :password)
    end

    def create
        puts "Trying to Create New user"
        @user = User.new(user_params)
        if @user.save
            puts "User successfully created"
            head 200, content_type: "text/json"
        else
            puts "Something went wrong while creating new User"
            head 500, content_type: "text/json"
        end
    end
end
