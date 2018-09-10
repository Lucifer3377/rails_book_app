class BooksController < ApplicationController
  layout "mylayout"
  def index
    @books = Book.all
    @authors = Author.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(param_permit)
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
    if @book.update_attributes(param_permit)
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
    params.require(:book).permit(:author_id,:name,:s_dec,:l_desc,:date_of_prod,:price,:genre_list)
  end
end
