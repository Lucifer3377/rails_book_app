class AuthorsController < ApplicationController
  layout "application"
  before_action :authenticate_user!
  # before_action :param_permit, only: [:create, :update]
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource :author, :book, :review
  def search
    respond_to do |format|
      format.js {render template: "authors/search.js.erb"}
    end
  end
  
  def index
    if params[:search].present?
      @authors = Author.find_authors(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 10)
    else
      @authors = Author.visible.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 10)
    end
  end

  def new
    @author = Author.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @author = Author.new(param_permit)
    puts param_permit
    if @author.save
      flash[:notice] = "Author successfully created"
      begin
        respond_to do |format|
          format.js {render inline: "location.reload();" }
        end
      rescue => exception
        redirect_to authors_path
      end
      
    else
      flash[:error] = "Error in creating an author"
      render(new_author_path)
    end
  end

  def edit
    @author = Author.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @author = Author.find(params[:id])
    puts param_permit
    if @author.update_attributes(param_permit)
      #@author.updated_at = Time.now
      flash[:notice] = "Author has been updated successfully"
      begin
        respond_to do |format|
          format.js {render inline: "location.reload();" }
        end
      rescue => exception
        redirect_to authors_path
      end
    else
      flash[:error] = "Error in updating author"
      render(edit_author_path(@author))
    end
  end

  def show
    @author = Author.find(params[:id])
    @reviews = @author.reviews
    @id = @author.id
  end

  def delete
    @author = Author.find(params[:id])
    respond_to do |format|
      format.js #{render template: "authors/delete.js.erb"}
    end
  end

  def destroy
    @author = Author.find(params[:id]).destroy
    flash[:notice] = "Author removed successfully"
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def trend
    @authors = Author.all.select {|author| author.reviews.count >= 3}
    @books = Book.all.select {|book| book.reviews.count >= 3}
  end

private
  def param_permit
    params.require(:author).permit(:name,:active,:cover,:biography,:academics_list,:awards_list)
  end

  def sort_column
    Author.fields.keys.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
