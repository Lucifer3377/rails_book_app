class BooksController < ApplicationController
  layout "mylayout"
  def index
    if params[:search].blank?
      @books = Book.all
    else
      @books = Book.search(params[:search])
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(param_permit)
    date = Date.new(params["date_of_prod(1i)"].to_i,params["date_of_prod(2i)"].to_i,params["date_of_prod(3i)"].to_i)
    puts "\n\n\n\n\nDate #{date}\n\n\n\n\n\n"
    @book.date_of_prod = date
    puts param_permit
    if @book.save
      flash[:notice] = "Book successfully created"
      redirect_to(:action => "index")
    else
      flash[:error] = "Error in creating a book"
      render("new")
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    puts "\n\n\nThese are the attributes as usual #{params}\n\n\n"
    # if @book.update_attributes!(param_permit)
    if @book.update(author_id: params[:book][:author_id]) && @book.update(name: params[:book][:name]) && @book.update(s_desc: params[:book][:s_desc]) && @book.update(l_desc: params[:book][:l_desc]) && @book.update(date_of_prod: params[:book][:date_of_prod]) && @book.update(price: params[:book][:price]) && @book.update(genre: params[:book][:genre])
      @book.updated_at = Time.now
      @book.save
      flash[:notice] = "Book has been updated successfully"
      redirect_to(:action => "index")
    else
      flash[:error] = "Error in updating book"
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
  end

  def destroy
    @book = Book.find(params[:id]).destroy
    flash[:notice] = "Book removed successfully"
    redirect_to(:action => "index")
  end

private
  def param_permit
    params[:book][:genre] ||= []
    params.require(:book).permit(:author_id,:name,:s_desc,:l_desc,:date_of_prod,:price,genre: [])
  end
end
