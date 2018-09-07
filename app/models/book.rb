class Book
  include Mongoid::Document
  #include Mongoid::Attributes::Dynamic
  include Mongoid::Search
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, type: String, localize: true
  field :s_desc, type: String
  field :l_desc, type: String
  field :books_chapter_index, type: String, default: ""
  field :date_of_prod, type: Date, default: ->{Date.today}
  field :price, type: Integer, default: 0
  field :genre, type: Array, localize: true, default: []

  validates_presence_of :name,:s_desc,:price

  belongs_to :author
  has_many :reviews, as: :reviewable

  search_in :name, :price, :genre, author: :name

  scope :search, lambda {|q| where(:author_id => q)}

  def genre_list=(arg)
    self.genre = arg.split(",").map {|v| v.strip}
  end

  def genre_list
    self.genre.join(", ")
  end
end
