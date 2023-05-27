require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザ登録のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context 'ユーザーについて' do
      it '新規登録ができる' do
        expect(user).to be_valid
      end
    end
  end
end
