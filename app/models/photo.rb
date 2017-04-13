class Photo < ApplicationRecord
  belongs_to :product
  mount_uploader :avatar, AvatarUploader
end
