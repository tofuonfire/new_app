require 'rails_helper'

RSpec.describe "Posts", type: :system do
  it "新規投稿したあと、その投稿を編集して最後に削除する", js: true do
    user = FactoryBot.create(:user, username: "alice")

    visit root_path
    expect(page).to have_content "さらに詳しく"

    click_link "ログイン"
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "ログイン状態を保持"

    fill_in "ユーザーネーム/メールアドレス", with: "alice"
    fill_in "パスワード", with: "123456"
    click_button "ログインする"
    expect(page).to have_content "フィード"

    # 新規の投稿をする
    click_link "投稿"
    expect(current_path).to eq new_post_path

    attach_file "post[image]", "#{Rails.root}/spec/fixtures/test.jpg", make_visible: true
    fill_in "キャプションを入力...", with: "I love it."
    expect {
      click_button "投稿を送信"
    }.to change(Post, :count).by(1)

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "投稿が送信されました"

    post = Post.first
    expect(post.caption).to eq "I love it."
    expect(page).to have_link "a", href: "/posts/#{post.url_token}"

    click_link "a", href: "/posts/#{post.url_token}"
    expect(current_path).to eq post_path(post)
    expect(page).to have_content "I love it."

    # 投稿を編集する
    find('button.btn.dropdown-toggle.setting-btn').click
    click_link "投稿を編集"
    expect(current_path).to eq edit_post_path(post)
    expect(page).to have_button "投稿を送信"

    fill_in "キャプションを入力...", with: "I don't like it."
    click_button "投稿を送信"

    expect(current_path).to eq post_path(post)
    expect(page).to have_content "投稿が更新されました"
    expect(page).to_not have_content "I love it."
    expect(page).to have_content "I don't like it."
    
    # 投稿を削除する
    find('button.btn.dropdown-toggle.setting-btn').click
    page.all(".dropdown-item")[1].click
    expect(page).to have_content "投稿を削除しますか？"
    
    expect {
      find("a[href='#{post_path(post)}']").click
    }.to change(Post, :count).by(-1)

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "投稿は正常に削除されました"
    expect(page).to_not have_link "a", href: "/posts/#{post.url_token}"
    
  end
end