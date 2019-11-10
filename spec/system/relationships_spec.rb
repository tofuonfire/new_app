require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  it 'ユーザーをフォロー/フォロー解除する', js: true do
    alice = FactoryBot.create(:user,
                              name: 'Alice',
                              username: 'alice')

    bob = FactoryBot.create(:user,
                            name: 'Bob',
                            username: 'bobx')

    # ログインする
    visit root_path

    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'ログイン状態を保持'

    fill_in 'ユーザーネーム/メールアドレス', with: 'alice'
    fill_in 'パスワード', with: '123456'
    click_button 'ログインする'
    expect(page).to have_content 'フィード'

    # フォローするユーザーのプロフィールページに遷移
    visit user_path(bob)
    expect(page).to have_content '@bobx'

    expect do
      click_button 'フォロー'
      expect(page).to have_button 'フォロー中'
      expect(find('#pills-follower-tab')).to have_content 'フォロワー 1'
    end.to change(alice.following, :count).by(1) &
           change(bob.followers, :count).by(1)

    visit user_path(bob) # リロード
    click_link 'pills-follower-tab'
    expect(page).to have_content '@alice'

    # 現在のユーザーのプロフィールページに遷移
    click_on 'nav avatar image'
    expect(current_path).to eq user_path(alice)
    expect(page).to have_content 'ログアウト'

    expect(find('#pills-following-tab')).to have_content 'フォロー中 1'
    click_link 'pills-following-tab'
    expect(page).to have_content '@bobx'

    # フォローするユーザーのプロフィールページに遷移
    visit user_path(bob)
    expect(page).to have_content '@bobx'

    expect do
      click_button 'フォロー中'
      expect(page).to have_button 'フォロー'
      expect(find('#pills-follower-tab')).to have_content 'フォロワー 0'
    end.to change(alice.following, :count).by(-1) &
           change(bob.followers, :count).by(-1)

    visit user_path(bob) # リロード
    click_link 'pills-follower-tab'
    expect(page).to_not have_content '@alice'

    # 現在のユーザーのプロフィールページに遷移
    click_on 'nav avatar image'
    expect(current_path).to eq user_path(alice)
    expect(page).to have_content 'ログアウト'

    expect(find('#pills-following-tab')).to have_content 'フォロー中 0'
    click_link 'pills-following-tab'
    expect(page).to_not have_content '@bobx'
  end
end
