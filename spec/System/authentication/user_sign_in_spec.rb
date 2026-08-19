# spec/system/authentication/user_sign_in_spec.rb
require 'rails_helper'

RSpec.describe "User Sign In", type: :system do
  before do
    # Usa o driver nativo sem carregar navegadores pesados (Chrome/Firefox)
    driven_by(:rack_test)
  end

  it "renders the login page correctly with email and password fields" do
    # 1. Ação: Tenta acessar a rota de login
    visit "/login"

    # 2. Expectativas: O que o usuário deve ver na tela
    expect(page).to have_content("DevGuard")
    expect(page).to have_field("E-mail")
    expect(page).to have_field("Senha")
    expect(page).to have_button("Entrar")
  end
end