class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    # params[:session] :password e :email
    @user = User.where(  email: params[:session][:email],  
                      password: params[:session][:password]  ).first

    if @user
      session[:current_user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Email e/ou senha inválidos"
      redirect_to new_session_path 
    end
  end
  
end
