  require "carrierwave/mongoid"

class Author
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :biography, type: String
  field :academics, type: Array, default: []
  field :awards, type: Array, default: []
  field :active, type: Boolean, default: false
  field :cover, type: String

  mount_uploader :cover, CoverUploader

  validates_presence_of :name, :academics, :awards, :biography, :active
  validates :name, uniqueness: true

  has_many :books, :dependent => :destroy
  has_many :reviews, as: :reviewable, :dependent => :delete

  scope :search, lambda {|q| where(:id => q)}
  scope :visible, ->{ where(active: true) }

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

  def self.find_authors(search)
    authors = Author.all
    authors = authors.where(name: /#{search["name"]}/) if search["name"].present?
    authors
  end
  # def self.search(search)
  #   puts "\n\nInside Search\n\n"
  #   if search
  #     puts "\n\nSearching.....\n\n"
  #     any_of({name: /#{search}/i},{biography: /#{search}/i})
  #   end
  # end
end
