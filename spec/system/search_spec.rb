require 'rails_helper'

RSpec.describe 'Search', type: :system do
  it '投稿/ユーザーを検索する', js: true do
    post1 = FactoryBot.create(:post, caption: 'This is the first post.')
    post2 = FactoryBot.create(:post, caption: 'This is the second post.')
    post3 = FactoryBot.create(:post, caption: 'First, preheat the oven.')

    alice = FactoryBot.create(:user, username: 'alice')
    bob = FactoryBot.create(:user, username: 'bobx')

    visit root_path

    # 未ログイン状態でもアクセスできること
    find('a.navbar-search-btn').click
    expect(current_path).to eq search_posts_path
    expect(page).to have_css '#q_caption_cont'

    click_link 'ユーザー'
    expect(current_path).to eq search_users_path
    expect(page).to have_css '#q_username_cont'

    # ログインする
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'ログイン状態を保持'

    fill_in 'ユーザーネーム/メールアドレス', with: 'alice'
    fill_in 'パスワード', with: '123456'
    click_button 'ログインする'
    expect(page).to have_content 'フィード'

    # ログイン状態でもアクセスできること
    find('a.navbar-search-btn').click
    expect(current_path).to eq search_posts_path
    expect(page).to have_css '#q_caption_cont'

    # 投稿を検索
    fill_in '投稿を検索', with: 'first'
    find('#q_caption_cont').native.send_key(:return)
    expect(page).to have_link 'a', href: "/posts/#{post1.url_token}"
    expect(page).to have_link 'a', href: "/posts/#{post3.url_token}"
    expect(page).to_not have_link 'a', href: "/posts/#{post2.url_token}"

    # ユーザーを検索
    click_link 'ユーザー'
    expect(current_path).to eq search_users_path
    expect(page).to have_css '#q_username_cont'
    fill_in 'ユーザーを検索', with: 'alice'
    find('#q_username_cont').native.send_key(:return)
    expect(page).to have_content '@alice'
    expect(page).to_not have_content '@bobx'
  end
end
