require 'rails_helper'

RSpec.describe BuyerShippingAddress, type: :model do
  before do
    @buyer_shipping_address = FactoryBot.build(:buyer_shipping_address)
  end

  describe "商品購入機能" do
    context '商品購入がうまく行く時' do
      it '全ての値が存在すれば登録できる（
      user_id、item_id、postal_code、prefecture_id、municipality、address、building、phone_number、buyer_id、token
      ）' do
        expect(@buyer_shipping_address).to be_valid
      end

      it 'postal_codeに"-"が入っていれば登録できる' do
        @buyer_shipping_address.postal_code = "123-4567"
        expect(@buyer_shipping_address).to be_valid
      end

      it 'phone_numberにハイフンがなく、かつ11桁以内であれば登録できる' do
        @buyer_shipping_address.phone_number = "09012345678"
        expect(@buyer_shipping_address).to be_valid
      end
    end

    context "商品登録がうまくいかない時" do
      it 'tokenが空だと登録できない' do
        @buyer_shipping_address.token = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空だと登録できない' do
        @buyer_shipping_address.postal_code = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeに"-"が入っていないと登録できない' do
        @buyer_shipping_address.postal_code = "1234567"
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Postal code is invalid")
      end

      it 'prefecture_idが空だと登録できない' do
        @buyer_shipping_address.prefecture_id = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idが選択されていないと登録できない' do
        @buyer_shipping_address.prefecture_id = 1
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'municipalityが空だと登録できない' do
        @buyer_shipping_address.municipality = nil
        @buyer_shipping_address.valid?
        # binding.pry
        expect(@buyer_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'addressが空だと登録できない' do
        @buyer_shipping_address.address = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと登録できない' do
        @buyer_shipping_address.phone_number = nil
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberに"-"が含まれていると登録できない' do
        @buyer_shipping_address.phone_number = "090-1234-5678"
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Phone number is not a number")
      end

      it 'phone_numberが12桁以上だと登録できない' do
        @buyer_shipping_address.phone_number = "090123456789"
        @buyer_shipping_address.valid?
        expect(@buyer_shipping_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
    end
  end
end
