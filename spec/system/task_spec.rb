require "rails_helper"

RSpec.describe "タスク管理機能", type: :system do
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        visit new_task_path
        fill_in "タスク名", with: "test_name"
        fill_in "タスクの詳細", with: "test_detail"
        select "着手", from: "ステータス"
        select "低", from: "優先度"
        fill_in "期限", with: "002023-05-22"
        click_button "登録"
        click_link "詳細"
        expect(page).to have_content "test_name"
      end
    end
  end
  describe "一覧表示機能" do
    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        task = FactoryBot.create(:task, task_name: "test")
        visit tasks_path
        expect(page).to have_content "test"
      end
    end
    context "タスクが作成日時の降順に並んでいる場合" do
      before do
        FactoryBot.create(:task, task_name: "1", created_at: Time.zone.now)
        FactoryBot.create(:task, task_name: "2", created_at: 1.day.from_now)
        FactoryBot.create(:task, task_name: "3", created_at: 1.day.ago)
      end
      it "新しいタスクが一番上に表示される" do
        visit tasks_path
        within ".task_list" do
          task_names = all(".task_name").map(&:text)
          expect(task_names).to eq %w(2 1 3)
        end
      end
    end
  end
  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        task = FactoryBot.create(:task, task_name: "test")
        visit tasks_path
        click_link "詳細"
        expect(page).to have_content "test"
      end
    end
  end
end
