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
  
  it "allows a user to sign in with valid credentials" do
    # Arrange: Prepara o usuário no banco de testes
    user = User.create!(
      email: "dev@devguard.com",
      password: "password123",
      password_confirmation: "password123"
    )

    # Act: Navega e submete os dados de acesso
    visit "/login"
    fill_in "E-mail", with: user.email
    fill_in "Senha", with: "password123"
    click_button "Entrar"

    # Assert: Valida a mensagem de feedback e o redirecionamento para o Dashboard
    expect(page).to have_content("Login realizado com sucesso!")
    expect(page).to have_current_path(root_path)
  end
  
  it "prevents user from signing in with invalid credentials" do
    # 1. Arrange: Usuário cadastrado no banco de dados
    user = User.create!(
      email: "dev@devguard.com",
      password: "password123",
      password_confirmation: "password123"
    )

    # 2. Act: Tentativa de login com senha incorreta
    visit "/login"
    fill_in "E-mail", with: user.email
    fill_in "Senha", with: "wrongpassword"
    click_button "Entrar"

    # 3. Assert: Permanece na mesma página, exibe mensagem de alerta e não redireciona
    expect(page).to have_content("E-mail ou senha inválidos.")
    expect(page).to have_current_path(login_path)
  end
  it "allows an authenticated user to log out" do
    # Arrange: Cria e autentica o usuário
    user = User.create!(
      email: "dev@devguard.com",
      password: "password123",
      password_confirmation: "password123"
    )

    visit "/login"
    fill_in "E-mail", with: user.email
    fill_in "Senha", with: "password123"
    click_button "Entrar"

    # Act: Clica no botão de Sair no Dashboard
    click_button "Sair"

    # Assert: Espera mensagem de confirmação e redirecionamento para o login
    expect(page).to have_content("Sessão encerrada com sucesso!")
    expect(page).to have_current_path(login_path)
  end
end