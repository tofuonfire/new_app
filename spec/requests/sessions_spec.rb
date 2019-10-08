require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  context "認証済みのユーザーとして" do
    describe "GET /users/sign_in" do
      it "トップページにリダイレクトされること" do
        user = FactoryBot.create(:user)
        sign_in user
        get new_user_session_path

        expect(response).to have_http_status "302"
        expect(response).to redirect_to "/"
      end
    end
  end

  context "ゲストとして" do
    describe "GET /users/sign_in" do
      it "正常にレスポンスを返すこと" do
        get new_user_session_path
        expect(response).to have_http_status "200"
      end
    end
  end
end
