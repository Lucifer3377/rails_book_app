class Book
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  #include Mongoid::Search
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
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

  validates_presence_of :name,:s_desc,:price, :genre, :l_desc, :author_id
  validates_numericality_of :price, greater_than: 0, :only_integer => true, :message => "should be greater than zero"
  

  belongs_to :author
  has_many :reviews, as: :reviewable

  #search_in :name, :price, :genre, author: %i[name]

  # scope :order, lambda {|q| where(:author_id => q)}
  #serialize :genre

  # def genre_list=(arg)
  #   self.genre = arg.split(",").map {|v| v.strip}
  # end

  # def genre_list
  #   self.genre.join(", ")
  # end

  def self.search(search)
    puts "\n\nInside Search\n\n"
    if search
      puts "\n\nSearching.....\n\n"
      any_of({name: /#{search}/i},{s_desc: /#{search}/i},{genre: /#{search}/i},{price: /#{search}/i})#,{author: %i[name] => /#{search}/i})
    end
  end

  def self.genre_types
    ["Science fiction",
      "Satire",
      "Drama",
      "Action",
      "Adventure",
      "Romance",
      "Mystery",
      "Horror"]
  end
end
