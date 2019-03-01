class Category < ApplicationRecord
	has_many :products, dependent: :nullify
	has_ancestry orphan_strategy: :adopt
end
