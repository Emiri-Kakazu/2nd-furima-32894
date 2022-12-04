class PurchaseItem
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipilities, :street_number, :building, :telephone_number

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
    validates :municipilities
  end

  with_options presence: true, format: { with: /\A0[0-9]{9,10}\z/, message: '半角数字、ハイフン無しで入力してください' } do
    validates :telephone_number
  end

  def save
    # ユーザーの情報を保存し、「user」という変数に入れている
    user = User.create(user_id: current_user.id)
    # 商品の情報を保存し、「item」という変数に入れている。中身は紐付いた商品のid。
    item = Item.find(params[:id])
    # 購入の情報を保存
    Purchase.create(user_id: user.id, item_id: item.id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, street_number: street_number, building: building, purchase_id: purchase.id)  
  end

  private
  def purchase_params
    params.require(:item).permit(:user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :street_number, :building)
  end


end