# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    # Busca o usuário pelo e-mail em minúsculas
    user = User.find_by(email: params[:email]&.downcase)

    # O método .authenticate é fornecido pelo has_secure_password
    if user&.authenticate(params[:password])
      # Salva o ID do usuário de forma criptografada nos cookies da sessão
      session[:user_id] = user.id
      redirect_to root_path, notice: "Login realizado com sucesso!"
    else
      flash.now[:alert] = "E-mail ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    # Limpa completamente a chave de usuário gravada no cookie de sessão
    session[:user_id] = nil
    redirect_to login_path, notice: "Sessão encerrada com sucesso!", status: :see_other
  end
end