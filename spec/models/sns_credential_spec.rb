require 'rails_helper'

RSpec.describe SnsCredential, type: :model do
  before do
    @sns_credential = FactoryBot.build(:sns_credential)
  end

  context '新規登録がうまく行く時' do
    it 'userの登録がなくても登録できる' do
      @sns_credential.user = nil
      expect(@sns_credential).to be_valid
    end
  end
  
end
