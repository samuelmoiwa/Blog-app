class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id
  validates :name, presence: true, length: { in: 1..255 }
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :posts_counter, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def three_posts
    posts.order(created_at: :desc).limit(3)
  end
end
