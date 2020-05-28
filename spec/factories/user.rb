FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'user1@user.com' }
    password { 'password' }
    is_admin { false }

    factory :admin do
       name { Faker::Name.name }
	    email { 'admin@user.com' }
	    password { 'password' }
	    is_admin { true }
    end

    factory :user2 do
       name { Faker::Name.name }
	    email { 'user2@user.com' }
	    password { 'password' }
	    is_admin { false }
    end
  end
end