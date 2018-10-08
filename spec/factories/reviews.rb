#require 'faker'
#I18n.reload!                 #to be used if faker isn't loading

FactoryBot.define do
    factory :random_author_review,class: Review do
      # association :author, factory: :random_author
        reviewable_id {Author.all.map {|x| x.id if x.active}.compact.sample}
        reviewable_type {"Author"}
        name {Faker::Name.first_name}
        star_rate {rand(1..5)}
        title {Faker::Lorem.sentence}
        desc {Faker::Lorem.sentence(100, true, 4)}
      end

      factory :random_book_review,class: Review do
        # association :book, factory: :random_book
        reviewable_id {Book.all.map {|x| x.id if !x.out_of_stock}.compact.sample}
        reviewable_type {"Book"}
        name {Faker::Name.first_name}
        star_rate {rand(1..5)}
        title {Faker::Lorem.sentence}
        desc {Faker::Lorem.sentence(100, true, 4)}
      end
  end