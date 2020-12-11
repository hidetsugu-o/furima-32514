class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX, message: '英字と数字の両方を使用してください' }

  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/.freeze
  validates :last_name, :first_name, presence: true, format: { with: NAME_REGEX, message: '全角文字を使用してください' }

  KANA_REGEX = /\A[ァ-ヶ]+\z/.freeze
  validates :last_kana, :first_kana, presence: true, format: { with: KANA_REGEX, message: '全角カナを使用してください' }
end
