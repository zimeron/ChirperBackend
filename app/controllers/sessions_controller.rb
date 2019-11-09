class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      response.status=(200)
      render json: {status: "Success", message: ["Log in Successful!"], userid: user.id, username: user.username}
    else 
      response.status=(401)
      render json: {status: "Error", message: ["Username or password invalid"]}
    end
  end

  def destroy
    session[:user_id] = nil
    response.status=(200)
    render json: {status: "Success", message: ["Successfully Logged Out"]}
  end
end
