require 'rails_helper'

RSpec.describe "SignUp", type: :system do
  before do
    ActionMailer::Base.deliveries.clear
  end

  def extract_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  it "ユーザーを作成したあと、メールアドレスを認証してログインする" do
    visit root_path
    expect(page).to have_content "さらに詳しく"

    click_link "新規登録"
    expect(current_path).to eq new_user_registration_path
    expect(page).to have_content "小文字の半角英数字と'_'(アンダーバー)のみ"

    # 登録に失敗する場合
    fill_in "名前", with: ""
    fill_in "ユーザーネーム", with: "users" # 既存のルーティング("/users")と重複するユーザーネーム
    fill_in "メールアドレス", with: "sample@invalid"
    fill_in "パスワード", with: "123456"
    fill_in "パスワードの再入力", with: "abcdef"

    click_button "アカウントを作成する"
    expect(page).to have_content "名前が未入力です"
    expect(page).to have_content "ユーザーネームは既に使用されています"
    expect(page).to have_content "メールアドレスは有効でありません"
    expect(page).to have_content "パスワードの再入力が一致しません"
    
    # 登録に成功する場合
    fill_in "名前", with: "Sample User"
    fill_in "ユーザーネーム", with: "sample"
    fill_in "メールアドレス", with: "sample@example.com"
    fill_in "パスワード", with: "123456"
    fill_in "パスワードの再入力", with: "123456"

    expect {
      click_button "アカウントを作成する"
    }.to change(User, :count).by(1) &
         change { ActionMailer::Base.deliveries.size }.by(1)

    expect(current_path).to eq confirm_email_path
    expect(page).to have_content "メールを送信しました"

    mail = ActionMailer::Base.deliveries.last
    confirmation_url = extract_url(mail)

    aggregate_failures do
      expect(mail.to).to eq ["sample@example.com"]
      expect(mail.from).to eq ["info@example.com"]
      expect(mail.subject).to eq "アカウントの登録確認"
      expect(mail.body).to match "Sample User"
      expect(mail.body).to match "(@sample)"
      expect(mail.body).to have_link "メールアドレスを認証", href: confirmation_url
    end

    user = User.last
    token = user.confirmation_token

    visit user_confirmation_path(confirmation_token: token)
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "おめでとうございます。メールアドレスは正常に承認されました。"
    
    fill_in "ユーザーネーム/メールアドレス", with: "sample"
    fill_in "パスワード", with: "123456"
    click_button "ログインする"
    expect(page).to have_content "フィード"
  end

end
