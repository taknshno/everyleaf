require "rails_helper"

RSpec.describe "ユーザ管理機能", type: :system do
  describe "ユーザ登録のテスト" do
    it "ユーザの登録ができること" do
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
    it "ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移する" do
      visit tasks_path
      expect(current_path).to eq new_session_path
    end
  end
  describe "セッション機能のテスト" do
    let!(:user) { FactoryBot.create(:user, email: "sample@example.com",
      password: "sample_pass", password_confirmation: "sample_pass", id: 10) }
    let!(:admin_user) { FactoryBot.create(:admin_user, id: 20) }
    it "ログインができる" do
      visit new_session_path
      fill_in "Email", with: "sample@example.com"
      fill_in "Password", with: "sample_pass"
      click_button "ログインする"
      expect(page).to have_content "タスク一覧"
    end
    it "自分の詳細画面(マイページ)に飛べること" do
      visit new_session_path
      fill_in "Email", with: "sample@example.com"
      fill_in "Password", with: "sample_pass"
      click_button "ログインする"
      find(".close").click
      click_link "プロフィール"
      expect(current_path).to eq user_path(id: 10)
    end
    it "一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること" do
      visit new_session_path
      fill_in "Email", with: "sample@example.com"
      fill_in "Password", with: "sample_pass"
      click_button "ログインする"
      visit user_path(id: 20)
      find(".close").click
      expect(page).to have_content "タスク一覧"
      expect(current_path).to eq "/"
    end
    it "ログアウトができること" do
      visit new_session_path
      fill_in "Email", with: "sample@example.com"
      fill_in "Password", with: "sample_pass"
      click_button "ログインする"
      find(".close").click
      click_link "ログアウト"
      expect(current_path).to eq new_session_path
    end
  end
  describe "管理画面のテスト" do
    let!(:user) { FactoryBot.create(:user, email: "sample@example.com",
      password: "sample_pass", password_confirmation: "sample_pass", id: 10) }
    let!(:admin_user) { FactoryBot.create(:admin_user, email: "admin@example.com",
      password: "admin_pass", password_confirmation: "admin_pass", admin: true, id: 20) }
    it "管理ユーザは管理画面にアクセスできること" do
      visit new_session_path
      fill_in "Email", with: "admin@example.com"
      fill_in "Password", with: "admin_pass"
      click_button "ログインする"
      visit admin_users_path
      expect(page).to have_content "管理画面"
    end
    it "一般ユーザは管理画面にアクセスできないこと" do
      visit new_session_path
      fill_in "Email", with: "sample@example.com"
      fill_in "Password", with: "sample_pass"
      click_button "ログインする"
      find(".close").click
      visit admin_users_path
      find(".close").click
      expect(current_path).to eq "/"
    end
    it "管理ユーザはユーザの新規登録ができること" do
      visit new_session_path
      fill_in "Email", with: "admin@example.com"
      fill_in "Password", with: "admin_pass"
      click_button "ログインする"
      visit admin_users_path
      click_link "管理権限でユーザー作成"
      fill_in "名前", with: "test_name"
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "123456"
      fill_in "パスワード(再確認)", with: "123456"
      click_button "登録する"
      find(".close").click
      expect(page).to have_content "test_name"
    end
    it "管理ユーザはユーザの詳細画面にアクセスできること" do
      visit new_session_path
      fill_in "Email", with: "admin@example.com"
      fill_in "Password", with: "admin_pass"
      click_button "ログインする"
      visit admin_users_path
      find("#show_10").click
      expect(page).to have_content "sample@example.com"
    end
    it "管理ユーザはユーザの編集画面からユーザを編集できること" do
      visit new_session_path
      fill_in "Email", with: "admin@example.com"
      fill_in "Password", with: "admin_pass"
      click_button "ログインする"
      visit admin_users_path
      find("#edit_10").click
      fill_in "名前", with: "edit_name"
      fill_in "メールアドレス", with: "edit@example.com"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード(再確認)", with: "12345678"
      click_button "編集する"
      find("#show_10").click
      expect(page).to have_content "edit_name"
    end
    it "管理ユーザはユーザの削除をできること" do
      visit new_session_path
      fill_in "Email", with: "admin@example.com"
      fill_in "Password", with: "admin_pass"
      click_button "ログインする"
      visit admin_users_path
      expect(page).to have_content "sample@example.com"
      find("#delete_10").click
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content "sample@example.com"
    end
  end
end
