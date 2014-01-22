class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to "/", notice: "Usuário criado com sucesso!"
    else
      flash[:error] = "Erro ao criar o usuário"
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :cpf, :password, :email, :password_confirmation)
  end
  
end
