# Handles authentication of user and session creation/deletion
class SessionsController < ApplicationController
  def new
  end

  # Creates session by authenticating against the stored password digest
  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      response.status=(200)
      render json: {status: "Success", message: ["Log in Successful!"], userid: user.id, username: user.username}
    else 
      # Error handling
      response.status=(401)
      render json: {status: "Error", message: ["Username or password invalid"]}
    end
  end

  # Ends session on a DELETE request from the front.
  def destroy
    session[:user_id] = nil
    response.status=(200)
    render json: {status: "Success", message: ["Successfully Logged Out"]}
  end
end
