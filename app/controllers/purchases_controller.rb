class PurchasesController < ApplicationController
  def index
    @purchase_item = PurchaseItem.new
    @item = Item.find(params[:item_id])
  end

  def create
    binding.pry
  end



end
