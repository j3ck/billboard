class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :vkontakte, :twitter, :google_oauth2]
  has_many :adverts, dependent: :destroy

  class << self
    def find_for_social_oauth(auth)
      User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = "#{auth.uid}@#{auth.provider}.com"
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end
end
