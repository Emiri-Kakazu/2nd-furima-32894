class PurchasesController < ApplicationController
  def index
    @purchase_item = PurchaseItem.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_item = PurchaseItem.new(purchase_params)
    @item = Item.find(params[:item_id])
    if @purchase_item.valid?
      @purchase_item.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def purchase_params
    params.require(:purchase_item).permit(:postal_code, :prefecture_id, :municipalities, :street_number, :building, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
