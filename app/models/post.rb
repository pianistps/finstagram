class Post < ActiveRecord::Base
  belongs_to :user

  validates :caption, :post_photo, presence: true
end
