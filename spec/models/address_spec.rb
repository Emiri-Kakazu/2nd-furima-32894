require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end
  
  describe '配送先保存機能' do
    context '保存できる場合' do
      it '郵便番号、都道府県、市区町村、番地、電話番号が存在して購入テーブルとも紐づいていて保存できる場合' do
        expect(@address).to be_valid
      end
    end

    context '保存できない場合' do
      it '郵便番号がないので保存できない' do
        @address.postal_code = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '都道府県が無選択なので保存できない' do
        @address.prefecture_id = '0'
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村がないので保存できない' do
        @address.municipalities = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '番地がないので保存できない' do
        @address.street_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Street number can't be blank")
      end

      it '電話番号がないので保存できない' do
        @address.telephone_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Telephone number can't be blank")
      end

      it '郵便番号が半角ハイフンあり7桁でないので保存できない' do
        @address.postal_code = '１４１００１４'
        @address.valid?
        expect(@address.errors.full_messages).to include("半角数字、ハイフンを入れてください")
      end

      it '市区町村が全角文字でないので保存できない' do
        @address.municipalities = 'Seattle City'
        @address.valid?
        expect(@address.errors.full_messages).to include("全角文字を使用してください")
      end

      it '電話番号が半角ハイフンありの書式でないので保存できない' do
        @address.telephone_number = '０１２０４４４４４４'
        @address.valid?
        expect(@address.errors.full_messages).to include("半角数字、ハイフン無しで入力してください")
      end

      it '購入idが紐づいていないので保存できない' do
        @address.purchase_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Purchase must exist")
      end

    end
  end
end
