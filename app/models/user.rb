class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :orders
  has_many :carts

  has_many :favorites
  has_many :favorite_products, through: :favorites, source: :product

  has_many :reviews, dependent: :destroy

  has_many :identifies

  mount_uploader :image, ImageUploader

  def admin?
    is_admin
  end

  def favorite_product?(product)
    favorite_products.include?(product)
  end

  def favorite!(product)
    favorite_products << product
  end

  def unfavorite!(product)
    favorite_products.delete(product)
  end

  def self.from_google(access_token, signed_in_resource=nil)
    data = access_token.info
    identify = Identify.find_by(:provider => access_token.provider, :uid => access_token.uid)

    if identify
      return identify.user
    else
      user = User.find_by(:email => access_token.email)
      if !user
        user = User.create(
          nickname: data["name"],
          email: data["email"],
          image: data["image"],
          password: Devise.friendly_token[0,20]
        )
      end
      identify = Identify.create(
        provider: access_token.provider,
        uid: access_token.uid,
        user: user
      )
    return user
    end
  end

  def self.from_facebook(access_token, signed_in_resoruce=nil)
    data = access_token.info
    identify = Identify.find_by(provider: access_token.provider, uid: access_token.uid)

    if identify
      return identify.user
    else
      user = User.find_by(:email => data.email)
      if !user
        user = User.create(
          nickname: access_token.extra.raw_info.name,
          email: data.email,
          image: data.image,
          password: Devise.friendly_token[0,20]
        )
      end
      identify = Identify.create(
        provider: access_token.provider,
        uid: access_token.uid,
        user: user
      )
      return user
    end
  end

  def self.from_github(access_token, signed_in_resoruce=nil)
		data = access_token["info"]
		identify = Identify.find_by(provider: access_token["provider"], uid: access_token["uid"])

		if identify
			return identify.user
		else
			user = User.find_by(:email => data["email"])

			if !user

				if data["name"].nil?
					name = data["nickname"]
				else
					name = data["name"]
				end

				user = User.create(
					nickname: name,
					email: data["email"],
					image: data["image"],
					password: Devise.friendly_token[0,20]
				)
			end

			identify = Identify.create(
				provider: access_token["provider"],
				uid: access_token["uid"],
				user: user
			)

			return user
		end
  end
end
