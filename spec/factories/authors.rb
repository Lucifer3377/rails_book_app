#require 'faker'
#I18n.reload!                 #to be used if faker isn't loading

FactoryBot.define do
    factory :random_author,class: Author do
        name {Faker::Book.author}
        biography {Faker::Lorem.sentence(3, true, 4)}
        academics {Faker::Lorem.words(6, true)}
        awards {Faker::Lorem.words(6, true)}
        active {Faker::Boolean.boolean(0.5)}
      end
  end