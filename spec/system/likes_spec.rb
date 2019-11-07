require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  it '投稿をいいね/いいね解除する', js: true do
    post = FactoryBot.create(:post, caption: 'Good morning.')
    alice = FactoryBot.create(:user, username: 'alice')

    # ログインする
    visit root_path
    expect(page).to have_content 'さらに詳しく'

    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'ログイン状態を保持'

    fill_in 'ユーザーネーム/メールアドレス', with: 'alice'
    fill_in 'パスワード', with: '123456'
    click_button 'ログインする'
    expect(page).to have_content 'フィード'

    # 投稿にいいねをする
    visit post_path(post)
    expect(page).to have_content 'Good morning.'
    expect(find('#pills-like-tab')).to have_content 'いいね！された数 0'

    expect do
      click_button 'いいね！'
      expect(find('.like-form')).to have_button 'いいね！済み'
      expect(find('#pills-like-tab')).to have_content 'いいね！された数 1'
    end.to change(post.likes, :count).by(1)

    visit post_path(post) # リロード
    click_link 'pills-like-tab'
    expect(page).to have_content '@alice'

    # 現在のユーザーのプロフィールページに遷移
    visit user_path(alice)
    expect(page).to have_content 'ログアウト'

    expect(find('#pills-lover-tab')).to have_content 'いいね 1'
    click_link 'pills-lover-tab'
    expect(page).to have_selector "a[href='#{post_path(post)}']"

    # 投稿のいいねを解除する
    visit post_path(post)
    expect(page).to have_content 'Good morning.'

    expect do
      click_button 'いいね！済み'
      expect(find('.like-form')).to have_button 'いいね！'
      expect(find('#pills-like-tab')).to have_content 'いいね！された数 0'
    end.to change(post.likes, :count).by(-1)

    visit post_path(post) # リロード
    click_link 'pills-like-tab'
    expect(page).to_not have_content '@alice'

    # 現在のユーザーのプロフィールページに遷移
    visit user_path(alice)
    expect(page).to have_content 'ログアウト'

    expect(find('#pills-lover-tab')).to have_content 'いいね 0'
    click_link 'pills-lover-tab'
    expect(page).to_not have_selector "a[href='#{post_path(post)}']"
  end
end
