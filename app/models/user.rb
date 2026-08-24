# app/models/user.rb
class User < ApplicationRecord
  # Adiciona os métodos de senha criptografada (password, password_confirmation, authenticate)
  has_secure_password

  # Normaliza o e-mail para minúsculas antes de persistir no banco
  before_save { self.email = email&.downcase }

  # Validações exigidas pelo Shoulda Matchers no teste
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }, 
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end