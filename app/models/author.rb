class Author
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :name, type: String, localize: true
  field :biography, type: String
  field :pic_png, type: BSON::Binary
  field :academics, type: String
  field :awards, type: String

  index "name.de" => 1
  index "name.en" => 1
end
