class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :cart_items, dependent: :destroy
  has_many :favorites
  has_many :fans, through: :favorites, source: :user
  has_many :reviews, dependent: :destroy
  belongs_to :category

  has_many :photos
  accepts_nested_attributes_for :photos

  scope :recent, -> { order("created_at DESC")}
end
