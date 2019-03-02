class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]
  has_many :products, dependent: :nullify
  has_ancestry orphan_strategy: :adopt,  :cache_depth=>true
  

  def should_generate_new_friendly_id?
    if !slug?
      title_changed?
    else
      false
    end
  end

end
