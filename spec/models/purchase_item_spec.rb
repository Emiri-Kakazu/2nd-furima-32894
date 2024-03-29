require 'rails_helper'

RSpec.describe PurchaseItem, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase = FactoryBot.create(:purchase)
    @purchase_item = FactoryBot.build(:purchase_item, user_id: @user.id, item_id: @item.id, purchase_id: @purchase.id)
  end

  describe '配送先保存機能' do
    context '保存できる場合' do
      it '郵便番号、都道府県、市区町村、番地、電話番号、トークンが存在して購入テーブルとも紐づいていて保存できる場合' do
        expect(@purchase_item).to be_valid
      end

      it '建物名が空でも保存できる場合' do
        @purchase_item.building = ''
        expect(@purchase_item).to be_valid
      end
    end

    context '保存できない場合' do
      it '郵便番号がないので保存できない' do
        @purchase_item.postal_code = ''
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Postal code can't be blank")
      end

      it '都道府県が無選択なので保存できない' do
        @purchase_item.prefecture_id = '0'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村がないので保存できない' do
        @purchase_item.municipalities = ''
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '番地がないので保存できない' do
        @purchase_item.street_number = ''
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Street number can't be blank")
      end

      it '電話番号がないので保存できない' do
        @purchase_item.telephone_number = ''
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Telephone number can't be blank")
      end

      it '郵便番号が半角ハイフンあり7桁でないので保存できない' do
        @purchase_item.postal_code = '１４１００１４'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Postal code 半角数字、ハイフンを入れてください')
      end

      it '市区町村が全角文字でないので保存できない' do
        @purchase_item.municipalities = 'Seattle City'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Municipalities 全角文字を使用してください')
      end

      it '電話番号が全角なので保存できない' do
        @purchase_item.telephone_number = '０１２０４４４４４４'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Telephone number 半角ハイフン無し、0から始まる10桁or11桁、で入力してください')
      end

      it '電話番号にハイフンがあるので保存できない' do
        @purchase_item.telephone_number = '090-1234-5678'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Telephone number 半角ハイフン無し、0から始まる10桁or11桁、で入力してください')
      end

      it '電話番号が9桁以下なので保存できない' do
        @purchase_item.telephone_number = '090123456'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Telephone number 半角ハイフン無し、0から始まる10桁or11桁、で入力してください')
      end

      it '電話番号が12桁以上なので保存できない' do
        @purchase_item.telephone_number = '090123456789'
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include('Telephone number 半角ハイフン無し、0から始まる10桁or11桁、で入力してください')
      end

      it '商品が紐づいていないので保存できない' do
        @purchase_item.item_id = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Item can't be blank")
      end

      it 'ユーザーが紐づいていないので保存できない' do
        @purchase_item.user_id = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("User can't be blank")
      end

      it 'トークンがないので保存できない' do
        @purchase_item.token = nil
        @purchase_item.valid?
        expect(@purchase_item.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
