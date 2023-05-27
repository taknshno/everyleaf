require "rails_helper"

RSpec.describe "ユーザ管理機能", type: :system do
  describe "ユーザ登録のテスト" do
    context "ユーザを新規登録した場合" do
      it "ユーザの登録ができる" do
        visit new_user_path
        fill_in "名前", with: "test_name"
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "123456"
        fill_in "パスワード(再確認)", with: "123456"
        click_button "登録する"
        find(".close").click
        click_link "プロフィール"
        expect(page).to have_content "test_name"
      end
    end
    context "ユーザがログインせずタスク一覧画面に飛ぼうとしたとき" do
      it "ログイン画面に遷移する" do
        visit tasks_path
        expect(current_path).to eq  new_session_path
      end
    end
  end
end
