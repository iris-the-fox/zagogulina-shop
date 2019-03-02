class AddPosToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :pos, :integer
  end
end
