class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :products, dependent: :nullify
  has_ancestry orphan_strategy: :adopt
end
