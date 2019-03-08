FactoryBot.define do

  factory :category, class: Category do
    title {"sometitle"}
    id {1}
  end

  factory :child_category, class: Category do
    title {"sometitle-child"}
    id {2}
    ancestry {1}
  end

end