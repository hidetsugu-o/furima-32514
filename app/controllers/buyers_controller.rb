class BuyersController < ApplicationController
  def index
    @buyer_shipping_address = BuyerShippingAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @buyer_shipping_address = BuyerShippingAddress.new(buyer_params)
    if @buyer_shipping_address.valid?
      @buyer_shipping_address.save
      redirect_to root_path
    else
      @buyer_shipping_address = BuyerShippingAddress.new(buyer_params[:errors])
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private
  def buyer_params
    params.require(:buyer_shipping_address).permit(:user_id, :item_id, :postal_code, :prefecture_id, :municipality, :address, :building, :phone_number, :buyer_id)
  end
end
