require "carrierwave/mongoid"
class Book
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  #include Mongoid::Search
  include Mongoid::Timestamps
  #include Mongoid::Pagination

  # include Kaminari::MongoidExtension::Criteria
  # include Kaminari::MongoidExtension::Document

  field :name, type: String
  field :s_desc, type: String
  field :l_desc, type: String
  field :books_chapter_index, type: String, default: ""
  field :date_of_prod, type: Date
  field :price, type: Integer, default: 0
  field :genre, type: Array, default: []
  field :cover, type: String
  field :out_of_stock, type: Boolean, default: false

  mount_uploader :cover, CoverUploader

  validates_presence_of :name,:s_desc,:price, :genre, :l_desc, :author_id, :out_of_stock
  validates_numericality_of :price, greater_than: 0, :only_integer => true, :message => "should be an integer greater than zero"
  

  belongs_to :author
  has_many :reviews, as: :reviewable, :dependent => :delete

  scope :instock, ->{where(out_of_stock: false)}
  
  def self.find_books(search)
    books = Book.all
    books = books.where(name: /#{search["name"]}/i) if search["name"].present?
    books = books.in(genre: /#{search["genre_type"]}/) if search["genre_type"].present?
    books = books.where(price: {"$gte" => search["min_price"],"$lte" => search["max_price"]}) if search["min_price"].present? || search["max_price"].present?
    books
  end
end
