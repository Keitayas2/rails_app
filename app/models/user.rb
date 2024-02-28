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
    has_many :relationships #フォロー機能のアソシエーション
    has_many :followings, through: :relationships, source: :follow #フォロー機能のアソシエーション
    has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id' #フォロー機能のアソシエーション
    has_many :followers, through: :reverse_of_relationships, source: :user #フォロー機能のアソシエーション
  def already_liked?(post)
    self.likes.exists?(post_id: post.id) #いいね重複防止
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)  #フォロー重複防止
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id) #フォロー解除
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)  #フォローしているかどうか
  end


end
