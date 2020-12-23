require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまく行く時' do
      it '全ての値が存在すれば登録できる（nickname、email、password、password_confirmation、last_name、first_name、last_kana、first_kana、birthday）' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上で、かつ半角英数字混合であれば登録できる' do
        @user.password = '000aaa'
        @user.password_confirmation = '000aaa'
        expect(@user).to be_valid
      end

      it 'last_name、first_nameが全角（漢字 or ひらがな or カタカナ）であれば登録できる' do
        @user.last_name = '漢字ひらがなカタカナ'
        @user.first_name = '漢字ひらがなカタカナ'
        expect(@user).to be_valid
      end

      it 'last_kana、first_kanaが全角（カタカナ）であれば登録できる' do
        @user.last_kana = 'カタカナ'
        @user.first_kana = 'カタカナ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない時（ユーザー情報）' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空だと登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it 'emailが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it 'emailが@を含まないと登録できない' do
        @user.email = 'yahoo.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end

      it 'passwordが空だと登録できない' do
        @user.password = nil
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが5文字以下だと登録できない' do
        @user.password = '000aa'
        @user.password_confirmation = '000aa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordに全角が含まれると登録できない' do
        @user.password = 'あ000aa'
        @user.password_confirmation = 'あ000aa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英字と数字の両方を使用してください")
      end

      it 'passwordが半角英字だけでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英字と数字の両方を使用してください")
      end

      it 'passwordが数字だけでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英字と数字の両方を使用してください")
      end

      it 'passwordとpassword_confirmationが異なる値だと登録できない' do
        @user.password = '000aaa'
        @user.password_confirmation = '111bbb'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end

    context '新規登録がうまくいかない時（本人情報確認）' do
      it 'last_nameが空だと登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it 'last_nameに半角英字が含まれると登録できない' do
        @user.last_name = 'aあ'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角文字を使用してください")
      end

      it 'first_nameに半角英字が含まれると登録できない' do
        @user.first_name = 'aあ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角文字を使用してください")
      end

      it 'last_nameに半角数字が含まれると登録できない' do
        @user.last_name = '0あ'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角文字を使用してください")
      end

      it 'first_nameに半角数字が含まれると登録できない' do
        @user.first_name = '0あ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角文字を使用してください")
      end

      it 'last_kanaが空だと登録できない' do
        @user.last_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください")
      end

      it 'first_kanaが空だと登録できない' do
        @user.first_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください")
      end

      it 'last_kanaに半角英字が含まれると登録できない' do
        @user.last_kana = 'aカ'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は全角カナを使用してください")
      end

      it 'first_kanaに半角英字が含まれると登録できない' do
        @user.first_kana = 'aカ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は全角カナを使用してください")
      end

      it 'last_kanaに半角数字が含まれると登録できない' do
        @user.last_kana = '0カ'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は全角カナを使用してください")
      end

      it 'first_kanaに半角英字が含まれると登録できない' do
        @user.first_kana = '0カ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は全角カナを使用してください")
      end

      it 'last_kanaに全角漢字が含まれると登録できない' do
        @user.last_kana = '漢カ'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は全角カナを使用してください")
      end

      it 'first_kanaに全角漢字が含まれると登録できない' do
        @user.first_kana = '漢カ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は全角カナを使用してください")
      end

      it 'last_kanaに全角ひらがなが含まれると登録できない' do
        @user.last_kana = 'あカ'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は全角カナを使用してください")
      end

      it 'first_kanaに全角ひらがなが含まれると登録できない' do
        @user.first_kana = 'あカ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は全角カナを使用してください")
      end

      it 'birthdayが空だと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
