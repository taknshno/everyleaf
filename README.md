### Model

#### User

| Field           | Type      |
|-----------------|-----------|
| id              | Integer   |
| user_name       | String    |
| email           | String    |
| password_digest | String    |
| created_at      | DataTime  |
| updated_at      | DataTime  |


#### Task

| Field       | Type      |
|-------------|-----------|
| id          | Integer   |
| user_id     | Integer   |
| task_name   | String    |
| task_detail | Text      |
| status      | Integer   |
| priority    | Integer   |
| end_date    | Date      |
| created_at  | DateTime  |
| updated_at  | DateTime  |

#### Label

| Field       | Type      |
|-------------|-----------|
| id          | Integer   |
| label_name  | String    |
| created_at  | DataTime  |
| updated_at  | DataTime  |

#### Task_Label

| Field       | Type      |
|-------------|-----------|
| id          | Integer   |
| task_id     | Integer   |
| label_id    | Integer   |
| created_at  | DataTime  |
| updated_at  | DataTime  |

---

### バージョン情報
・Ruby 3.0.1
・Ruby on Rails 6.1.7.3


### HEROKUへのデプロイ

1. herokuにログインし、アプリを作成する
```
$ heroku login
$ heroku create
```

2. Gemfileに以下を追加 (※ Ruby3系を使用する場合)
```
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
```

3. Heroku buildpackを追加する
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

4. デプロイを実行する
```
$ git push heroku master
```