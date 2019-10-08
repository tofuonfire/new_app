require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  context "認証済みのユーザーとして" do
    before do
      user = FactoryBot.create(:user)
      sign_in user
    end

    describe "GET /users/password/new" do
      it "トップページにリダイレクトされること" do
        get new_user_password_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to "/"
      end
    end

    describe "GET /users/password/edit" do
      it "トップページにリダイレクトされること" do
        get edit_user_password_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to "/"
      end
    end
  end

  context "ゲストとして" do
    describe "GET /users/password/new" do
      it "正常にレスポンスを返すこと" do
        get new_user_password_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /users/password/edit" do
      it "ログインページにリダイレクトされること" do
        get edit_user_password_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
