class PurchasesController < ApplicationController
  #before_action :purchase, only: [:create] 
  def index
    @purchase_item = PurchaseItem.new
    @item = Item.find(params[:item_id])
  end

  def create
    #binding.pry
    @purchase_item = PurchaseItem.new(purchase_params)
    @item = Item.find(params[:item_id])
    #card = Card.find_by(user_id: current_user.id)
    if @purchase_item.valid?
      purchase
      @purchase_item.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def purchase_params
    params.require(:purchase_item).permit(:postal_code, :prefecture_id, :municipalities, :street_number, :building, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def purchase
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    #customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
    #PurchasedItem.create(item_id: params[:id]) # 商品のid情報を「item_id」として保存する
  end
end
