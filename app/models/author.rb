class Author
  include Mongoid::Document
  #include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, type: String, localize: true
  field :biography, type: String
  #field :pic_png, type: BSON::Binary
  field :academics, type: Array, default: []
  field :awards, type: Array, default: []

  validates_presence_of :name

  has_many :books, validate: false
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
