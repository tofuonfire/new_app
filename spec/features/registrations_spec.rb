require 'rails_helper'

RSpec.feature "Registrations", type: :feature do
  describe "Signup" do

    before { visit new_user_registration_path }

    # 入力情報が有効である場合  
    # context "valid signup information" do
    #   scenario "user creates an account" do
    #     expect {
    #       fill_in "Username", with: "user"
    #       fill_in "Email", with: "user@example.com"
    #       fill_in "Password", with: "password"
    #       fill_in "Password confirmation", with: "password"
    #       click_button "Create your account"

    #       expect(page).to have_content("Post")
    #       expect(page).to have_content("Notification")
    #     }.to change(User, :count).by(1)

    #     expect(page).to have_current_path(user_path(User.last))
    #     expect(current_path).to eq(user_path(User.last))
    #   end
    # end

    # 情報が無効である場合
    context "invalid signup information" do
      scenario "user fails to create an account" do
        expect {
          fill_in "Username", with: ""
          fill_in "Email", with: "user@invalid"
          fill_in "Password", with: "foo"
          fill_in "Password confirmation", with: "bar"
          click_button "Create your account"

          expect(page).to have_content("prohibited this user from being saved")
        }.to_not change(User, :count)
      end
    end

  end
end
