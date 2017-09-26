class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  validates :title, presence: true, length: { minimum: 10, maximum: 200 }
  validates :body, presence: true, length: { minimum: 30 }

  default_scope -> { order('created_at DESC') }
end
