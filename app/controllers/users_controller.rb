class UsersController < ApplicationController
    # Creates a new user from the data in a POST request
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

    # Returns some users the given user is not already following
    def toFollow
        @following = []
        if User.find(params[:id]).following != nil
            @following = User.find(params[:id]).following
        end
        @following.push(params[:id])
        @users = []
        User.where.not(id: @following)
            .order(created_at: :desc)
            .find_each(:batch_size => 20) do |user|
            @users.push(user)
        end
        render json: @users.to_json
    end

    # Returns the user data by id
    def show
        if(User.exists?(user_params[:id]))
            @user = User.find(user_params[:id])
        end
        render json: @user.to_json
    end

    # Updates user data from a PUT request (currently only Following)
    def update
        puts "Trying to Update user data"
        @user = User.update(params[:id], :following => params[:following])
        if @user.save
            puts "User data successfully updated"
            response.status=(200)
            render json: { status: "Success", message: ["Follow successful!"]}
        else
            puts "Something went wrong while updating user data"
            puts(@user.error.full_messages)
            response.status=(422)
            render json: { status: "Error", message: [@user.error.full_messages]}
        end
    end

    private

    # Strong parameter allowance
    def user_params
        params.permit(:id, :username, :password, :password_confirmation, :following)
    end

end
