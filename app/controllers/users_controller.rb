class UsersController < ApplicationController

    def create
        puts "Trying to Create New user"
        puts params
        @user = User.new(params[:id][:username][:password])        
        if @user.save
            puts "User successfully created"
            head 200, content_type: "text/json"
        else
            puts "Something went wrong while creating new User"
            head 500, content_type: "text/json"
        end
    end
end
