class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  has_many :likes, dependent: :destroy #いいね機能のアソシエーション
  has_many :liked_users, through: :likes, source: :user #いいね機能のアソシエーション
  has_many :comments, dependent: :destroy #コメント機能のアソシエーション

end
