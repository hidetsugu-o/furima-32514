require 'rails_helper'

RSpec.describe BuyerShippingAddress, type: :model do
  before do
    @buyer_shipping_address = FactoryBot.build(:buyer_shipping_address)
  end

  describe '商品購入機能' do
    context '商品購入がうまく行く時' do
      it '全ての値が存在すれば購入できる（
      user_id、item_id、postal_code、prefecture_id、municipality、address、building、phone_number、buyer_id、token
      ）' do
        expect(@buyer_shipping_address).to be_valid
      end

      it 'postal_codeに"-"が入っていれば購入できる' do
        @buyer_shipping_address.postal_code = '123-4567'
        expect(@buyer_shipping_address).to be_valid
      end

      it 'phone_numberにハイフンがなく、かつ11桁以内であれば購入できる' do
        @buyer_shipping_address.phone_number = '09012345678'
        expect(@buyer_shipping_address).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @buyer_shipping_address.building = nil
        expect(@buyer_shipping_address).to be_valid
      end
    end

    context '商品購入がうまくいかない時' do
      it 'user_idが空だと購入できない' do
        @buyer_shipping_address.user_id = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Userを入力してください")
      end

      it 'item_idが空だと購入できない' do
        @buyer_shipping_address.item_id = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenが空だと購入できない' do
        @buyer_shipping_address.token = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("正しいクレジットカード情報を入力してください")
      end

      it 'postal_codeが空だと購入できない' do
        @buyer_shipping_address.postal_code = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'postal_codeに"-"が入っていないと購入できない' do
        @buyer_shipping_address.postal_code = '1234567'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'prefecture_idが空だと購入できない' do
        @buyer_shipping_address.prefecture_id = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("都道府県を入力してください")
      end

      it 'prefecture_idが選択されていないと購入できない' do
        @buyer_shipping_address.prefecture_id = 1
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'municipalityが空だと購入できない' do
        @buyer_shipping_address.municipality = nil
        @buyer_shipping_address.valid?
        # binding.pry
        expect(@buyer_shipping_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'addressが空だと購入できない' do
        @buyer_shipping_address.address = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空だと購入できない' do
        @buyer_shipping_address.phone_number = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'phone_numberに"-"が含まれていると購入できない' do
        @buyer_shipping_address.phone_number = '090-1234-5678'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("電話番号は数値で入力してください")
      end

      it 'phone_numberが12桁以上だと購入できない' do
        @buyer_shipping_address.phone_number = '090123456789'
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
    end
  end
end
