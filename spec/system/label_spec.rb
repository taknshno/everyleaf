require "rails_helper"

RSpec.describe "ラベル管理機能", type: :system do
  let!(:user) { FactoryBot.create(:user, id: 3) }
  let!(:admin_user) { FactoryBot.create(:admin_user, id: 6) }
  let!(:label) { FactoryBot.create(:label, label_name: "abc", id: 100)}
  let!(:second_label) { FactoryBot.create(:second_label, label_name: "lmn" , id: 200)}
  let!(:third_label) { FactoryBot.create(:third_label, label_name: "xyz" , id: 300)}
  let!(:task) { FactoryBot.create(:task, id: 10, task_name: "apple", user_id: 6, label_ids:[100] ) }
  let!(:second_task) { FactoryBot.create(:second_task, id: 20, task_name: "banana", user_id: 6, label_ids: [200] ) }
  let!(:third_task) { FactoryBot.create(:second_task, id: 30, task_name: "orange", user_id: 6, label_ids: [300] ) }
  let!(:fourth_task) { FactoryBot.create(:fourth_task, id: 40, task_name: "grape", user_id: 6, label_ids: [200, 300] ) }

  describe "ラベル管理画面へのアクセス制限" do
    include_context "login_setup"
    it "一般ユーザーはラベル作成画面への遷移に失敗する" do
      visit new_admin_label_path
      expect(current_path).to eq "/"
    end
  end

  describe "ラベル管理画面の表示" do
    include_context "admin_login_setup"
    it "管理ユーザーはラベル作成画面への遷移に成功する" do
      visit new_admin_label_path
      expect(current_path).to eq new_admin_label_path
    end
  end

  describe "ラベル新規作成" do
    include_context "admin_login_setup"
    it "ラベル作成画面に移動してラベルを作成する" do
      visit new_admin_label_path
      fill_in "label[label_name]", with: "test_label"
      click_button "登録する"
      expect(page).to have_content "test_label"
    end
  end

  describe "ラベル一覧表示" do
    include_context "admin_login_setup"
    it "ラベル管理画面に移動して一覧表示する" do
      visit admin_labels_path
      expect(page).to have_content "abc"
      expect(page).to have_content "lmn"
    end
  end
  describe "ラベル編集機能" do
    include_context "admin_login_setup"
    it "ラベル管理画面に移動してラベルを編集する" do
      visit admin_labels_path
      find("#edit_100").click
      fill_in "label[label_name]", with: "edit_label"
      click_button "編集する"
      expect(page).to have_content "edit_label"
    end
  end
  describe "ラベル削除機能" do
    include_context "admin_login_setup"
    it "管理画面に移動してラベルを削除する" do
      visit admin_labels_path
      expect(page).to have_content "abc"
      find("#delete_100").click
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content "abc"
    end
  end
  describe "ラベルの付いたタスクの作成" do
    include_context "admin_login_setup"
    context "ラベルを付けたタスクを作成したとき" do
      it "タスク詳細画面で、紐づいているラベル一覧を出力する" do
      visit new_task_path
      fill_in "task[task_name]", with: "test_name"
      fill_in "task[task_detail]", with: "test_detail"
      select "着手", from: "task[status]"
      select "低", from: "task[priority]"
      fill_in "task[end_date]", with: "002023-05-22"
      find('#task_label_ids_200').click
      find('#task_label_ids_300').click
      click_button "登録"
      find("#show_40").click
      expect(page).to have_content "lmn"
      expect(page).to have_content "xyz"
      end
    end
  end
  describe "タスク削除時に関連付けを削除" do
    include_context "admin_login_setup"
    context "タスクに付けられているラベル自体を削除したとき" do
      it "ラベルの関連付けも削除される" do
        visit task_path(id: 40)
        expect(page).to have_content "lmn"
        visit admin_labels_path
        find("#delete_200").click
        page.driver.browser.switch_to.alert.accept
        visit task_path(id: 40)
        expect(page).not_to have_content "lmn"
      end
    end
  end

  describe "ラベルでタスクを検索する" do
    include_context "admin_login_setup"
    context "特定のラベルを選択してタスク検索をしたとき" do
      it "選択したラベルのついたタスクだけが表示される" do
        visit tasks_path
        select "lmn", from: "key_label_id"
        click_button "検索"
        expect(page).to have_content "banana"
      end
    end
  end
end