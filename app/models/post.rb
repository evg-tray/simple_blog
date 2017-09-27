class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 10, maximum: 200 }
  validates :body, presence: true, length: { minimum: 30 }

  default_scope -> { order('created_at DESC') }
  scope :public_posts, -> { where(public: true) }
end
