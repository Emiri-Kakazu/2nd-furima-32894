class PurchaseItem
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :street_number, :building, :telephone_number, :purchase_id

  with_options presence: true, numericality: { only_integer: true, message: "半角数字を使用してください" } do
    validates :user_id
    validates :item_id
  end

  with_options presence: true, format: { with: /\A\d{3}[-]\d{4}\z/, message: '半角数字、ハイフンを入れてください' } do
    validates :postal_code
  end

  with_options presence: true, numericality: { other_than: 0, message: "can't be blank" } do
    validates :prefecture_id
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :municipalities
  end

  with_options presence: true do
    validates :street_number
  end

  with_options presence: true, format: { with: /\A0[0-9]{9,10}\z/, message: '半角数字、ハイフン無しで入力してください' } do
    validates :telephone_number
  end

  def save
    # 商品
    #item = Item.new(params[:item_id])
    # purchasesテーブルにフォームの情報を保存し、「purchase」という変数に入れている
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    # addressesテーブルにフォームの情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, street_number: street_number, building: building, telephone_number: telephone_number, purchase_id: purchase.id)

  end

end