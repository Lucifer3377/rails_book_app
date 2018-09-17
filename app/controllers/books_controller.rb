class BooksController < ApplicationController
  layout "mylayout"
  def index
    if params[:search].blank?
      @books = Book.order_by(:name => :desc).paginate(:page => params[:page], :per_page => 3)
        #paginate(:page => 1, :limit => 10).desc(:_id)
    else
      @books = Book.search(params[:search]).paginate(:page => params[:page], :per_page => 3)
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(param_permit)
    date = DateTime.new(params["book"]["date_of_prod(1i)"].to_i,params["book"]["date_of_prod(2i)"].to_i,params["book"]["date_of_prod(3i)"].to_i)
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
    if @book.update(author_id: params[:book][:author_id]) && @book.update(name: params[:book][:name]) && @book.update(s_desc: params[:book][:s_desc]) && @book.update(l_desc: params[:book][:l_desc]) && @book.update(date_of_prod: params[:book][:date_of_prod]) && @book.update(price: params[:book][:price]) && @book.update(genre: params[:book][:genre] && @book.update(cover: params[:book][:cover]))
      #@book.updated_at = Time.now
      date = DateTime.new(params["book"]["date_of_prod(1i)"].to_i,params["book"]["date_of_prod(2i)"].to_i,params["book"]["date_of_prod(3i)"].to_i)
      puts "\n\n\n\n\nDate #{date}\n\n\n\n\n\n"
      @book.date_of_prod = date
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
  def param_permit
    params[:book][:genre] ||= []
    params.require(:book).permit(:author_id,:cover,:name,:s_desc,:l_desc,:date_of_prod,:price,genre: [])
  end
end
