# Mewblr
シンプルな画像投稿SNSです（ミューブラーと読みます）<br>
就活用のポートフォリオとして作成しました。

## URL
https://mewblr.com/

* 画面上部のバーから【ゲストユーザー】としてログインできます（ゲストユーザーのみユーザー情報の編集を制限しています）
* ユーザーネーム"admin"、パスワード"123456"で【管理ユーザー】としてログインできます。管理ユーザーは、他の一般ユーザーのアカウントや投稿の削除が可能です。
* 尚、[初期登録されているユーザー](https://mewblr.com/users/)はすべてパスワード"123456"でログインできます。

## 使用技術
* Ruby 2.6.5, Rails 6.0.0
* Nginx, Puma
* AWS
  * VPC
  * EC2
  * S3
  * RDS for MySQL
  * ALB
  * Route53
  * SES
  * ACM
* Capistrano
* SASS, Bootstrap, JQuery
* RSpec
  
## 機能一覧
* ユーザー登録・ログイン機能（deviseを使用）
* 投稿機能（画像のアップロードにCarrierWaveを使用）
* 投稿一覧・投稿詳細表示機能
* 投稿管理機能
* ページネーション機能（Kaminari + InfiniteScroll）
* フォロー機能（Ajax）
* いいね機能（Ajax）
* コメント機能（Ajax）
* 検索機能（Ransackを使用）
* 管理ユーザー機能（一般ユーザーのアカウントや投稿を削除可能）
* Twitterへのシェア機能
* Capistranoを用いたデプロイ機能
* Rspecによる自動テスト機能