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
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end

      it 'titleが空だと登録できない' do
        @item.title = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'profileが空だと登録できない' do
        @item.profile = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'category_idが空だと登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it 'category_idが選択されていないと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it 'status_idが空だと登録できない' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it 'status_idが選択されていないと登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end

      it 'delivery_fee_idが空だと登録できない' do
        @item.delivery_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it 'delivery_fee_idが選択されていないと登録できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end

      it 'prefecture_idが空だと登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it 'prefecture_idが選択されていないと登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end

      it 'days_to_ship_idが空だと登録できない' do
        @item.days_to_ship_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it 'days_to_ship_idが選択されていないと登録できない' do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end

      it 'priceが空だと登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end

      it 'priceが299以下だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
      end

      it 'priceが10000000以上だと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
      end

      it 'priceが全角文字だと登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end

      it 'priceが半角英数混合だと登録できない' do
        @item.price = 'a1000'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end

      it 'priceが半角英語だと登録できない' do
        @item.price = 'aaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end
    end
  end
end
