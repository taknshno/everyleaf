require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'task_nameが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: '', task_detail: 'test_detail', status: 1, priority: 1, end_date: 2023-05-22, user_id: 1)
        expect(task).not_to be_valid
      end
    end
    context 'task_detailが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: 'test_name', task_detail: '', status: 1, priority: 1, end_date: 2023-05-22, user_id: 1)
        expect(task).not_to be_valid
      end
    end
    context 'task_nameが入力されており、statusとpriorityが範囲内' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: 'test_name', task_detail: 'test_detail', status: 2, priority: 3, end_date: 2023-05-22, user_id: 1)
        expect(task).to be_valid
      end
    end
  end
  # describe '検索機能' do
  #   let!(:task) { FactoryBot.create(:task, task_name: 'task') }
  #   let!(:second_task) { FactoryBot.create(:second_task, task_name: "sample") }
  #   let(:third_task) { FactoryBot.create(:third_task, task_name: "task", status: "着手") }
  #   let(:fourth_task) { FactoryBot.create(:fourth_task, task_name: "sample", status: "未着手") }
  #   context 'scopeメソッドでタイトルのあいまい検索をした場合' do
  #     it "検索キーワードを含むタスクが絞り込まれる" do
  #       expect(Task.word_search('task')).to include(task)
  #       expect(Task.word_search('task')).not_to include(second_task)
  #       expect(Task.word_search('task').count).to eq 1
  #     end
  #   end
  #   context 'scopeメソッドでステータス検索をした場合' do
  #     it "ステータスに完全一致するタスクが絞り込まれる" do
  #       expect(Task.status_search('未着手')).to include(task)
  #       expect(Task.status_search('未着手')).not_to include(second_task)
  #       expect(Task.status_search('未着手').count).to eq 1
  #     end
  #   end
  #   context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
  #     it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
  #       expect(Task.word_search('task').status_search('未着手')).to include(task)
  #       expect(Task.word_search('task').status_search('未着手')).not_to include(second_task)
  #       expect(Task.word_search('task').status_search('未着手')).not_to include(third_task)
  #       expect(Task.word_search('task').status_search('未着手')).not_to include(fourth_task)
  #       expect(Task.word_search('task').status_search('未着手').count).to eq 1
  #     end
  #   end
  # end
end