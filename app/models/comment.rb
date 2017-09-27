class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true, length: { minimum: 10 }

  default_scope -> { order('created_at') }
end
