require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  context "認証済みのユーザーとして" do
    before do
      user = FactoryBot.create(:user)
      sign_in user
    end

    describe "GET /users/sign_up" do
      it "トップページにリダイレクトされること" do
        get new_user_registration_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to "/"
      end
    end

    describe "GET /confirm_email" do
      it "トップページにリダイレクトされること" do
        get confirm_email_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to "/"
      end
    end

    describe "GET /users/edit" do
      it "正常にレスポンスを返すこと" do
        get edit_user_registration_path
        expect(response).to have_http_status "200"
      end
    end
  end

  context "ゲストとして" do
    describe "GET /users/sign_up" do
      it "正常にレスポンスを返すこと" do
        get new_user_registration_path
        expect(response).to have_http_status "200"
      end
    end

    describe "GET /confirm_email" do
      it "正常にレスポンスを返すこと" do
        get confirm_email_path
        expect(response).to have_http_status "200"
      end
    end

    describe "GET /users/edit" do
      it "ログインページにリダイレクトされること" do
        get edit_user_registration_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
