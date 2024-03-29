# ECサイト（akoshop）です。
個人開発でECサイトを作りたいと思い制作しました。

# なぜこのポートフォリオを作ろうと思ったのか
自分のオリジナル商品のお店が欲しかったからです。
そして私の祖母がコーヒーが好きなのでコーヒーSHOPにしました
# サービス概要
架空の小規模なコーヒー販売ショップです。

# 難しかったこと
- 住所自動入力
- gemを使ってshoppingcartを実装したこと(参考記事が少ないgemだったため)
- raty.jsの平均の出し方
- ランキング機能(1位から3位までの色の分け方)
- bootstrapに全て頼らずなるべくscssで実装できるようにしました。
- soldout表示
- ルーティングの理解ができてなかったのでデータの取り方に苦戦しました。

# 主な機能

## 一般ユーザー
* 会員登録機能(住所・氏名・連絡先など)(住所自動入力)
* User ログイン機能
* ゲストログイン機能
* 退会機能
* アカウント編集
* パスワード変更機能
* クレジットカード登録機能
* 購入履歴表示
* お気に入り登録
* お気に入り登録した商品一覧
* 商品を購入する機能
* 商品をカートに入れる機能
* カートに入れた商品の購入を確定させる機能
* 購入した商品を確認できる機能
* 商品レビュー機能（raty.js）
* お問い合わせ機能
* 商品検索機能
* タグ検索機能

## 管理ユーザー
* 商品を登録する機能
* タグ機能
* カテゴリを登録する機能
* 受注一覧
* 顧客一覧
* 顧客を退会させる機能

## ER図

![ako-shop](https://user-images.githubusercontent.com/99533616/174321777-a4988fdb-a9f0-4a2c-b95f-faddd57c0cc5.jpg)


# 使用技術
## バックエンド
 * Ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [arm64-darwin20]
 * Rails 6.1.5
 * Rubocop

## フロントエンド
* HTML
* CSS(SCSS)
* JavaScript(jQuery)
* bootstrap4

# 主な Gem
* gem 'devise'
* gem 'jp_prefecture'
* gem 'socialization'
* gem 'kaminari'
* gem 'acts_as_shopping_cart'
* gem 'roo'
* gem 'payjp'
* gem 'better_errors'
* gem 'binding_of_caller'
* gem 'pry-rails'
* gem 'hamlit'
* gem 'erb2haml'
* gem 'rubocop-rails'

# その他
* jpostal.js
* raty.js

# 今後実装したいこと
- news機能
- 通知機能(売り切れ入荷した際に通知受け取るボタンを押した人に知らせる)
- ポイント機能
- ポイントからお支払いできる機能(ラジオボタンを使って実装)
- 発送ステータス設定
