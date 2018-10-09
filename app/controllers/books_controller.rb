class BooksController < ApplicationController
  layout "application"
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
  before_action :authorize_resources
  # load_and_authorize_resource :book

  def search
    respond_to do |format|
      format.js {render template: "books/search.js.erb"}
    end
  end

  def index
    if params[:author_id].present?
      @books = Book.where(:author_id => params[:author_id]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)  
    elsif !params[:search].blank?
      @books = Book.find_books(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
    else
      @books = Book.instock.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
    end
  end

  def new
    @book = Book.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @book = Book.new(param_permit)
    date = DateTime.new(params["book"]["date_of_prod(1i)"].to_i,params["book"]["date_of_prod(2i)"].to_i,params["book"]["date_of_prod(3i)"].to_i)
    @book.date_of_prod = date
    if @book.save
      flash[:notice] = "Book successfully created"
      begin
        respond_to do |format|
          format.js {render inline: "location.reload();" }
        end
      rescue => exception
        redirect_to books_path
      end
    else
      flash[:alert] = "Error in creating a book"
      render("new")
    end
  end

  def edit
    @book = Book.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @book = Book.find(params[:id])
    # if @book.update_attributes!(param_permit)
    if @book.update(author_id: params[:book][:author_id]) && 
      @book.update(name: params[:book][:name]) && 
      @book.update(s_desc: params[:book][:s_desc]) &&
      @book.update(l_desc: params[:book][:l_desc]) && 
      @book.update(date_of_prod: params[:book][:date_of_prod]) && 
      @book.update(price: params[:book][:price]) && 
      @book.update(genre: params[:book][:genre]) &&
      @book.update(out_of_stock: params[:book][:out_of_stock])
      #@book.updated_at = Time.now
      date = DateTime.new(params["book"]["date_of_prod(1i)"].to_i,params["book"]["date_of_prod(2i)"].to_i,params["book"]["date_of_prod(3i)"].to_i)
      @book.date_of_prod = date
      @book.cover = params[:book][:cover]
      @book.save
      flash[:notice] = "Book has been updated successfully"
      begin
        respond_to do |format|
          format.js {render inline: "location.reload();" }
        end
      rescue => exception
        redirect_to books_path
      end
    else
      flash[:alert] = "Error in updating book"
      render("edit")
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @id = @book.id
    @author = @book.author
  end

  def delete
    @book = Book.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    
    @book = Book.find(params[:id]).destroy
    flash[:notice] = "Book removed successfully"
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

private

  def authorize_resources
    if params[:action] == "index"
      authorize Book
    elsif params[:action] == "search"
      authorize Book
    elsif params[:action] == "show"
      authorize Book.new
      authorize Review
    elsif params[:action] == "new" || params[:action] == "create"
      authorize Book.new
    elsif params[:action] == "delete" || params[:action] == "destroy"
      authorize Book.new
    elsif params[:action] == "edit" || params[:action] == "update"
      authorize Book.new
    end
  end

  def param_permit
    #params[:book][:genre] ||= []
    params.require(:book).permit(:author_id,:out_of_stock,:cover,:name,:s_desc,:l_desc,:date_of_prod,:price,genre: [])
  end

  def sort_column
    Book.fields.keys.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
