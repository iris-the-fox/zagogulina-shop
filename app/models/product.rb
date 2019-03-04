class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  extend FriendlyId
  belongs_to :category
  friendly_id :title, :use => [:slugged, :history]
  validates_presence_of :title


  def should_generate_new_friendly_id?
    if !slug?
      title_changed?
    else
      false
    end
  end

end
