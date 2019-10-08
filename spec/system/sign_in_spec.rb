require 'rails_helper'

RSpec.describe "SignIn", type: :system do
  it "ユーザーネームとメールアドレスのどちらでもログインできること", js: true do
    FactoryBot.create(:user,
      username: "sample",
      email:    "sample@example.com",
      password: "123456")

    visit root_path
    expect(page).to have_content "新規登録"

    click_link "ログイン"
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "ログイン状態を保持"

    # ログインに失敗する場合
    click_button "ログインする"
    expect(page).to have_content \
      "入力されたユーザーネームやパスワードが正しくありません。"

    fill_in "ユーザーネーム/メールアドレス", with: "sample"
    fill_in "パスワード", with: "foobar"
    click_button "ログインする"
    expect(page).to have_content \
      "入力されたユーザーネームやパスワードが正しくありません。"

    # ユーザーネームを使ってログインする
    fill_in "ユーザーネーム/メールアドレス", with: "sample"
    fill_in "パスワード", with: "123456"
    click_button "ログインする"
    expect(page).to have_content "フィード"

    click_on "nav avatar image"
    expect(page).to have_content "ログアウト"

    find("a.logout").click
    expect(page).to have_content "ログアウトしますか？"

    click_on "ログアウト"
    expect(page).to have_content "新規登録"

    click_link "ログイン"
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "ログイン状態を保持"

    # メールアドレスを使ってログインする
    fill_in "ユーザーネーム/メールアドレス", with: "sample@example.com"
    fill_in "パスワード", with: "123456"
    click_button "ログインする"
    expect(page).to have_content "フィード"
  end

  it "メールアドレスが未承認のユーザーではログインできないこと" do
    FactoryBot.create(:user, :unconfirmed, username: "sample", password: "123456")

    visit new_user_session_path
    expect(page).to have_content "ログイン状態を保持"

    fill_in "ユーザーネーム/メールアドレス", with: "sample"
    fill_in "パスワード", with: "123456"
    click_button "ログインする"
    expect(page).to have_content "アカウントが有効化されていません。"
  end
end