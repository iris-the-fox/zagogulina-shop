FactoryBot.define do
  
  factory :user, class: User do

    email {"joe@gmail.com"}
    password {"123456"}
  end

   factory :admin, class: User do

    email {"jill@gmail.com"}
    password {"654321"}
    admin {true}
  end


end