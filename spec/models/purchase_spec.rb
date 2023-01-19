require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before do
    @purchase = FactoryBot.build(:purchase)
  end
  describe '商品購入機能' do
    context '購入できる場合' do
      it '商品idとユーザーidが存在して保存できる場合' do
        expect(@purchase).to be_valid
      end
    end

    context '購入できない場合' do
      it '商品idが紐づいていないので保存できない' do
        @purchase.item = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Item must exist')
      end

      it 'ユーザーidが紐づいていないので保存できない' do
        @purchase.user = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('User must exist')
      end
    end
  end
end
