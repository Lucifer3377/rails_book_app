#require 'faker'
#I18n.reload!                 #to be used if faker isn't loading

FactoryBot.define do
    factory :random_book,class: Book do
        # association :author, factory: :random_author
        author_id {Author.all.map {|x| x.id}.sample}
        name {Faker::Book.title}
        s_desc {Faker::Lorem.sentence(6, true, 4)}
        l_desc {Faker::Lorem.sentence(100, true, 4)}
        date_of_prod {DateTime.now}
        price {Faker::Number.number(3)}
        genre {GENRE_TYPES.sample(rand(1..8))}
        out_of_stock {Faker::Boolean.boolean(0.5)}
      end
  end