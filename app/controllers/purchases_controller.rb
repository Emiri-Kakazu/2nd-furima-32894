class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]

  def index
    # @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user.id

    @exist = Purchase.where(item_id: params[:item_id]).exists? # 返り値はTrue/False
    if @exist == true
      redirect_to root_path
    else
      @purchase_item = PurchaseItem.new
    end
  end

  def create
    @purchase_item = PurchaseItem.new(purchase_params)
    # @item = Item.find(params[:item_id])
    # card = Card.find_by(user_id: current_user.id)
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
    params.require(:purchase_item).permit(:postal_code, :prefecture_id, :municipalities, :street_number, :building, :telephone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def purchase
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 環境変数を読み込む
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
