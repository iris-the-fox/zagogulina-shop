class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]
  has_many :products, dependent: :nullify
  has_ancestry orphan_strategy: :adopt
  

  def should_generate_new_friendly_id?
    if !slug?
      name_changed?
    else
      false
    end
  end
  
end
