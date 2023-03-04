class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :check_item_purchased, only: [:index, :create]

  def index
    if @purchased_item == false
      if current_user.id != @item.user.id
        @purchase_item = PurchaseItem.new
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def create
    if @purchased_item == false
      if current_user.id != @item.user.id
        @purchase_item = PurchaseItem.new(purchase_params)
        if @purchase_item.valid?
          purchase
          @purchase_item.save
          redirect_to root_path
        else
          render action: :index
        end
      else
        redirect_to root_path
      end

    else
      redirect_to root_path
    end
  end

  private

  def purchase_params
    params.require(:purchase_item).permit(:postal_code, :prefecture_id, :municipalities, :street_number, :building, :telephone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def purchase
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_item_purchased
    @purchased_item = Purchase.where(item_id: @item.id).exists?
  end
end
