require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品がうまく行く時' do
      it '全ての値が存在すれば登録できる（
          image,title,profile,category_id,status_id,delivery_fee_id,prefecture_id,days_to_ship_id,price,user_id
          ）' do
        expect(@item).to be_valid
      end

      it 'priceが半角数字、かつ300以上であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it 'priceが半角数字、9999999以下であれば登録できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまく行かない時' do
      it 'imageが空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'titleが空だと登録できない' do
        @item.title = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it 'profileが空だと登録できない' do
        @item.profile = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Profile can't be blank")
      end

      it 'profileが空だと登録できない' do
        @item.profile = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Profile can't be blank")
      end

      it 'category_idが空だと登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'category_idが選択されていないと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択してください')
      end

      it 'status_idが空だと登録できない' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it 'status_idが選択されていないと登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status を選択してください')
      end

      it 'delivery_fee_idが空だと登録できない' do
        @item.delivery_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      end

      it 'delivery_fee_idが選択されていないと登録できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery fee を選択してください')
      end

      it 'prefecture_idが空だと登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idが選択されていないと登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を選択してください')
      end

      it 'days_to_ship_idが空だと登録できない' do
        @item.days_to_ship_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship can't be blank")
      end

      it 'days_to_ship_idが選択されていないと登録できない' do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Days to ship を選択してください')
      end

      it 'priceが空だと登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが300以下だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceが9999999以上だと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'priceが文字列だと登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
