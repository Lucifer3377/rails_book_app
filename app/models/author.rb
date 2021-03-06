  require "carrierwave/mongoid"

class Author
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :name, type: String
  field :biography, type: String
  field :academics, type: Array, default: []
  field :awards, type: Array, default: []
  field :active, type: Boolean, default: false
  field :cover, type: String

  mount_uploader :cover, CoverUploader

  validates_presence_of :name, :academics, :awards, :biography, :active
  validates :name, uniqueness: {:case_sensitive => false}

  has_many :books, :dependent => :destroy
  has_many :reviews, as: :reviewable, :dependent => :delete

  before_create :drop_the_case

  scope :search, lambda {|q| where(:id => q)}
  scope :visible, ->{ where(active: true) }
  
  @@book_array = []
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

  def self.print_exception(exception)
    puts "[Exception While Importing]#{exception.class}: #{exception.message}"
    puts exception.backtrace.join("\n")
  end  

  def self.import(file_name,path,user_id)
    errors_caught = []
    begin
      spreadsheet = open_spreadsheet(file_name,path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        author = Author.find_by(name: row["name"]) || new
        author.attributes = row.to_hash.slice(*row.to_hash.keys)
        if(!author.save)
          errors_caught << author.errors.messages
        end          
    end
    rescue RuntimeError => exception
      print_exception(exception)            
    end  
     
    if errors_caught.present?
      user = User.find_by(id: user_id) 
      ImportError.import_error_messages(user,errors_caught).deliver_now
      errors_caught = []
    end
  end

  def self.loadBookArray
    @@book_array = Book.collection.aggregate([{"$group" => {"_id" => "$author_id","count" => {"$sum" => 1}}}])
  end

  def self.getBookCount(id)
    @@book_array.find {|x| x[:_id] == id}[:count]
  end
  
  def self.open_spreadsheet(file_name,path)
    case File.extname(file_name)
      when ".csv" then Roo::CSV.new(path)
      when ".xls" then Roo::Excel.new(path)
      when ".xlsx" then Roo::Excelx.new(path)
      # when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise RuntimeError,"Unknown file type"
    end
  end

  protected
  def drop_the_case
    self.name = self.name.downcase
  end
end
