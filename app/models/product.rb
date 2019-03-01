class Product < ApplicationRecord
  extend FriendlyId
  belongs_to :category
  friendly_id :title, use: :slugged
end
