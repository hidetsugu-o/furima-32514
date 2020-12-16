class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.order('created_at DESC').includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    if current_user.id == item.user_id
      item.destroy
      redirect_to root_path
    else
      redirect_to new_user_registration_path
    end

  def edit
    @item = Item.find(params[id])
  end

  def update
    item = Item.find(params[id])
    item.update(item_params)
  end

  private

  def item_params
    params.require(:item).permit(
      :title, :profile, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end
