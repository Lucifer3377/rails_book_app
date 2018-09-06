class Review
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :ref_type, type: String
  field :ref_id, type: String, localize: true
  field :name, type: String, localize: true
  field :star_rate, type: Integer
  field :title, type: String
  field :desc, type: String

  index "name.de" => 1
  index "name.en" => 1
  index "ref_id.de" => 1
  index "ref_id.en" => 1
end
