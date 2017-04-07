class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :carts

  has_many :favorites
  has_many :favorite_products, through: :favorites, source: :product

  has_many :reviews, dependent: :destroy

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
end
