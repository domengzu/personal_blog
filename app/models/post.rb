class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true

  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy
end
