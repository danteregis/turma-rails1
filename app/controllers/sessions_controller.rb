class SessionsController < ApplicationController
  
  before_filter :check_user_logged_in, except: :destroy
  
  # authentication_needed
  skip_before_filter :authentication_needed, only: [:new, :create]
  
  def new
  end
  
  def create
    # params[:session] :password e :email
    
    @user = User.where(  email: params[:session][:email],  
                      password: params[:session][:password]  ).first

    if @user
      session[:current_user_id] = @user.id 
      flash[:notice] = "Parabéns, você fez o login corretamente"
      redirect_to "/"
    else
      flash[:error] = "Email e/ou senha inválidos"
      redirect_to new_session_path 
    end
  end
  
  # SESSIONS CONTROLLER
  
  def destroy
    session[:current_user_id] = nil
    redirect_to "/", notice: "Puxa, já vai embora? :("
  end
  
  
  private
  def check_user_logged_in
    if @current_user
      flash[:error] = "Você já está logado, energúmeno!"
      redirect_to "/"
    end
  end
end
