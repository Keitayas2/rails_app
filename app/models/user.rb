class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    mount_uploader :image, ImageUploader #画像投稿機能のアソシエーション
    has_many :posts, dependent: :destroy #投稿機能のアソシエーション
    has_many :likes, dependent: :destroy #いいね機能のアソシエーション
    has_many :liked_posts, through: :likes, source: :post #いいね機能のアソシエーション
    has_many :comments, dependent: :destroy #コメント機能のアソシエーション
    validates :name, presence: true #名前の空欄禁止
    validates :profile, length: { maximum: 200 } #プロフィールの文字数制限
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

end
