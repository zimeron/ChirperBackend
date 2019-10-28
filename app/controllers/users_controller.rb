class UsersController < ApplicationController
    def user_params
        params_require(:current_user).permit(:id, :username, :password)
    end

    def create
        User.create(user_params)
    end
end
