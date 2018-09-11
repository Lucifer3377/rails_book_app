class Review
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps::Created

  field :name, type: String, localize: true
  field :star_rate, type: Integer, default: 0
  field :title, type: String
  field :desc, type: String

  belongs_to :reviewable, polymorphic: true

  validates_presence_of :name, :star_rate, :title, :desc
  validates_numericality_of :star_rate, greater_than: 0, less_than: 6, :message => "Not a Number"
end
