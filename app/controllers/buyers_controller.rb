class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    @buyer_shipping_address = BuyerShippingAddress.new
    check_sold_or_sellor?
  end

  def create
    @buyer_shipping_address = BuyerShippingAddress.new(buyer_params)
    if @buyer_shipping_address.valid?
      pay_item
      @buyer_shipping_address.save
      redirect_to root_path
    else
      reset_buyer
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def buyer_params
    params.require(:buyer_shipping_address).permit(
      :postal_code, :prefecture_id, :municipality, :address, :building, :phone_number
    ).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def reset_buyer
    @buyer_shipping_address.postal_code = nil
    @buyer_shipping_address.prefecture_id = nil
    @buyer_shipping_address.municipality = nil
    @buyer_shipping_address.address = nil
    @buyer_shipping_address.building = nil
    @buyer_shipping_address.phone_number = nil
  end

  def check_sold_or_sellor?
    redirect_to root_path if @item.buyer || current_user.id == @item.user_id
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end
end
