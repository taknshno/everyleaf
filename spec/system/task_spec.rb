require "rails_helper"

RSpec.describe "タスク管理機能", type: :system do
  let!(:admin_user) { FactoryBot.create(:admin_user, id: 100) }
  describe "新規作成機能" do
    include_context "admin_login_setup"
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        visit new_task_path
        fill_in "task[task_name]", with: "test_name"
        fill_in "task[task_detail]", with: "test_detail"
        select "着手", from: "task[status]"
        select "低", from: "task[priority]"
        fill_in "task[end_date]", with: "002023-05-22"
        click_button "登録"
        click_link "詳細"
        expect(page).to have_content "test_name"
      end
    end
  end
  describe "一覧表示機能" do
    include_context "admin_login_setup"
    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        task = FactoryBot.create(:task, task_name: "test" , user_id: 100)
        visit tasks_path
        expect(page).to have_content "test"
      end
    end
    context "タスクが作成日時の降順に並んでいる場合" do
      before do
        FactoryBot.create(:task, task_name: "1", created_at: Time.zone.now, user_id: 100)
        FactoryBot.create(:task, task_name: "2", created_at: 1.day.from_now, user_id: 100)
        FactoryBot.create(:task, task_name: "3", created_at: 1.day.ago, user_id: 100)
      end
      it "新しいタスクが一番上に表示される" do
        visit tasks_path
        within ".task_area" do
          task_names = all(".task_name").map(&:text)
          expect(task_names).to eq %w(2 1 3)
        end
      end
    end
    context "「終了期限順」というボタンを押した場合" do
      before do
        FactoryBot.create(:task, task_name: "1", end_date: Time.zone.now, user_id: 100)
        FactoryBot.create(:task, task_name: "2", end_date: 1.day.from_now, user_id: 100)
        FactoryBot.create(:task, task_name: "3", end_date: 1.day.ago, user_id: 100)
      end
      it "終了期限の降順に並び替えられたタスク一覧が表示される" do
        visit tasks_path
        click_link "終了期限順"
        sleep 0.3
        within ".task_area" do
          task_names = all(".task_name").map(&:text)
          expect(task_names).to have_content %w(2 1 3)
        end
      end
    end
    context "検索機能を利用した場合" do
      before do
        FactoryBot.create(:task, task_name: "test_name1", status: 1, user_id: 100)
        FactoryBot.create(:task, task_name: "test_name2", status: 2, user_id: 100)
        FactoryBot.create(:task, task_name: "test_name3", status: 3, user_id: 100)
        FactoryBot.create(:task, task_name: "test_name3", status: 1, user_id: 100)
      end
      it "タイトルで検索できる" do
        visit tasks_path
        fill_in "key_word", with: "test_name1"
        click_button "検索"
        expect(page).to have_content "test_name1"
      end
      it "ステータスで検索できる" do
        visit tasks_path
        select "着手", from: "key_status"
        click_button "検索"
        expect(page).to have_content "test_name2"
      end
      it "タイトルとステータスで検索できる" do
        visit tasks_path
        fill_in "key_word", with: "test_name3"
        sleep 1
        select "未着手", from: "key_status"
        click_button "検索"
        expect(page).to have_content "test_name3"
        expect(page).to have_content "未着手"
      end
    end
  end
  describe "詳細表示機能" do
    include_context "admin_login_setup"
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        task = FactoryBot.create(:task, task_name: "test", user_id: 100)
        visit tasks_path
        click_link "詳細"
        expect(page).to have_content "test"
      end
    end
  end
end
