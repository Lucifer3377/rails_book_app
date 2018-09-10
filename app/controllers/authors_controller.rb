class AuthorsController < ApplicationController
  layout "mylayout"
  def index
    @authors = Author.all
    @books = Book.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(param_permit)
    puts param_permit
    if @author.save
      flash[:notice] = "Author successfully created"
      redirect_to(:action => "index")
    else
      flash[:error] = "Error in creating an author"
      render("new")
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    puts param_permit
    if @author.update_attributes(param_permit)
      @author.updated_at = Time.now
      flash[:notice] = "Author has been updated successfully"
      redirect_to(:action => "index")
    else
      flash[:error] = "Error in updating author"
      render("edit")
    end
  end

  def show
    @author = Author.find(params[:id])
    @reviews = @author.reviews
  end

  def delete
    @author = Author.find(params[:id])
  end

  def destroy
    @author = Author.find(params[:id]).destroy
    flash[:notice] = "Author removed successfully"
    redirect_to(:action => "index")
  end
private
  def param_permit
    params.require(:author).permit(:name,:cover,:biography,:academics_list,:awards_list)
  end
end
