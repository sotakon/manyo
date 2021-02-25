| Table      | Model       | Colum_name   | Date_type   |
|:----------:|:-----------:|:------------:|:-----------:|
| tasks      | Task        | name         |string       |
|            |             | limit        |string       |
|            |             | priority     |string       |
|            |             | status       |string       |
|            |             | id           |integer      |
| users      | User        | email        |string       |
|            |             | name         |string       |
|            |             | password     |integer      |
|            |             | user_id      |integer      |
| labels     | Label       | name         |string       |
|            |             | lebel_id     |integer      |

# Herokuへのデプロイ手順
1. アセットプリコンパイルをする
    1. $ rails assets:precompile RAILS_ENV=production
1. コミットする
    1. ~/workspace/heroku_test_app (master) $ git add -A
    1. ~/workspace/heroku_test_app (master) $ git commit -m "init"
1. Herokuに新しいアプリケーションを作成します。
    1. $ heroku create
1. Heroku stackを変更する
    1. $ heroku stack:set heroku-18
1. Heroku buildpackを追加する
    1. $ heroku buildpacks:set heroku/ruby
    1. $ heroku buildpacks:add --index 1 heroku/nodejs
1. Herokuにデプロイをする
    1. $ git push heroku master
1. データベースの移行
    1. $ heroku run rails db:migrate
1. 使用しているGem Bundler version 2.1.4