require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @user = FactoryBot.create(:user)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { username: @user.username }
      expect(response).to have_http_status(:success)
    end
  end

end
