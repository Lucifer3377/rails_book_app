class Book
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :author_id, type: Integer
  field :name, type: String, localize: true
  field :s_desc, type: String
  field :l_desc, type: String
  field :books_chapter_index, type: String
  field :date_of_prod, type: Date
  field :price, type: Integer
  field :genre, type: Array, localize: true

  index "name.de" => 1
  index "name.en" => 1
  index "genre.de" => 1
  index "genre.en" => 1
  index "price.en" => 1
  index "price.de" => 1
end
