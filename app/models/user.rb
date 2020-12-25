class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :nickname, :birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX, message: 'は半角英字と数字の両方を使用してください' }

  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/.freeze
  validates :last_name, :first_name, presence: true, format: { with: NAME_REGEX, message: 'は全角文字を使用してください' }

  KANA_REGEX = /\A[ァ-ヶ]+\z/.freeze
  validates :last_kana, :first_kana, presence: true, format: { with: KANA_REGEX, message: 'は全角カナを使用してください' }

  has_many :items
  has_many :buyers
  has_many :sns_credentials

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )

    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
