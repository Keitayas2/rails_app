class Like < ApplicationRecord
  belongs_to :post #いいね機能のアソシエーション
  belongs_to :user #いいね機能のアソシエーション

  validates_uniqueness_of :post_id, scope: :user_id #いいね重複防止
end
