  require "carrierwave/mongoid"

class Author
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, type: String, localize: true
  field :biography, type: String
  field :academics, type: Array, default: []
  field :awards, type: Array, default: []
  field :cover, type: String

  mount_uploader :cover, CoverUploader

  validates_presence_of :name, :academics, :awards, :biography
  validates :name, acceptance: true

  has_many :books
  has_many :reviews, as: :reviewable

  scope :search, lambda {|q| where(:id => q)}

  def academics_list=(arg)
    self.academics = arg.split(",").map {|v| v.strip}
  end

  def academics_list
    self.academics.join(", ")
  end

  def awards_list=(arg)
    self.awards = arg.split(",").map {|v| v.strip}
  end

  def awards_list
    self.awards.join(", ")
  end
end
