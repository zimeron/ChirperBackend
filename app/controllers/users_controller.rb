class UsersController < ApplicationController
    def create
        puts "Trying to Create New user"
        puts user_params
        @user = User.new(user_params)        
        if @user.save
            puts "User successfully created"
            response.status=(201)
            render json: {status: "Success",  message: ["Registration Successful!"]}
        else
            puts "Something went wrong while creating new User"
            puts(@user.errors.full_messages)
            response.status=(422)
            render json: { status: "Error", message: [@user.errors.full_messages]}
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
