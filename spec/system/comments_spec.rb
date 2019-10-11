require 'rails_helper'

RSpec.describe "Comments", type: :system do
  it "既存の投稿にコメントをして、削除する", js: true do
    post = FactoryBot.create(:post, caption: "I love it.")

    # 未ログイン状態ではコメントのフォームが表示されないこと
    visit post_path(post)
    expect(page).to_not have_css "textarea.comment"

    # ログインする
    user = FactoryBot.create(:user,
      name: "Alice",
      username: "alice",)

    visit root_path
    expect(page).to have_content "さらに詳しく"

    click_link "ログイン"
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "ログイン状態を保持"

    fill_in "ユーザーネーム/メールアドレス", with: "alice"
    fill_in "パスワード", with: "123456"
    click_button "ログインする"
    expect(page).to have_content "フィード"

    visit post_path(post)
    expect(page).to have_content "I love it."

    # ログイン状態ならコメントのフォームが表示されること
    expect(page).to have_css "textarea.comment"

    # 制限を超える文字数を入力した場合
    fill_in "コメントを入力...", with: "a" * 241
    expect(page).to have_content "文字数制限を超えています"
    expect(page).to_not have_css "#comment_btn"

    # 制限内の文字数を入力した場合
    fill_in "コメントを入力...", with: "a" * 240
    expect(page).to_not have_content "文字数制限を超えています" 
    expect(page).to have_css "#comment_btn"

    # コメントする
    fill_in "コメントを入力...", with: "very very beautiful"
    expect {
      find("#comment_btn").click
      expect(page).to have_content "very very beautiful"
    }.to change(post.comments, :count).by(1)
    
    # コメントを削除する
    comment = post.comments.first
    
    find("a.comment-delete").click
    expect(page).to have_content "コメントを削除しますか？"
    expect(page).to have_selector "a[href='#{post_comment_path(post, comment)}']"

    expect {
      find("a[href='#{post_comment_path(post, comment)}']").click
      expect(page).to have_content "まだコメントがありません"
    }.to change(Comment, :count).by(-1)

  end
end