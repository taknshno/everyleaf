require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'task_nameが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name: '', status: 1, priority: 1, end_date: 2023-05-22)
        expect(task).not_to be_valid
      end
    end
    context 'statusが範囲外の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: 'test', status: 100, priority: 1, end_date: 2023-05-22)
        expect(task).not_to be_valid
      end
    end
    context 'priorityが範囲外の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: 'test', status: 1, priority: 100, end_date: 2023-05-22)
        expect(task).not_to be_valid
      end
    end
    context 'task_nameが入力されており、statusとpriorityが範囲内' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: 'test', status: 2, priority: 3, end_date: 2023-05-22)
        expect(task).to be_valid
      end
    end
  end
end