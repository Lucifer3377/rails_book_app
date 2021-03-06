class AuthorsController < ApplicationController
  layout "application"
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
  before_action :authorize_resources
  # load_and_authorize_resource :author, :book, :review

  def search
    respond_to do |format|
      format.js {render template: "authors/search.js.erb"}
    end
  end
  
  def index
    Author.loadBookArray            #initialise array having book counts
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
      flash[:alert] = "Error in creating an author"
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
    if @author.update_attributes(param_permit)
      flash[:notice] = "Author has been updated successfully"
      begin
        respond_to do |format|
          format.js {render inline: "location.reload();" }
        end
      rescue => exception
        redirect_to authors_path
      end
    else
      flash[:alert] = "Error in updating author"
      render(edit_author_path(@author))
    end
  end

  def show
    @author = Author.find(params[:id])
    @reviews = @author.reviews
  end

  def delete
    @author = Author.find(params[:id])
    respond_to do |format|
      format.js
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

  def import
    begin  
      checkExt?(params[:file].original_filename)
      worker_job_id = SheetWorker.perform_async(params[:file].original_filename, params[:file].path,current_user.id)
    rescue
      redirect_to authors_url, alert: "File Not Supported."
      return
    end
    redirect_to authors_url, notice: 'Products imported.'      
  end

  private

  def authorize_resources
    if params[:action] == "index"
      authorize Author
    elsif params[:action] == "search"
      authorize Author
    elsif params[:action] == "show"
      authorize Author.new
      authorize Review
    elsif params[:action] == "new" || params[:action] == "create"
      authorize Author.new
    elsif params[:action] == "delete" || params[:action] == "destroy"
      authorize Author.new
    elsif params[:action] == "edit" || params[:action] == "update"
      authorize Author.new
    elsif params[:action] == "import"
      authorize Author
    elsif params[:action] == "trend"
      authorize Author
      authorize Book
    end
  end

  def checkExt?(filename)    
    case File.extname(filename)
      when ".csv" then true
      when ".xls" then true
      when ".xlsx" then true
      else raise RuntimeError,"Unknown file type"
    end
  end

  def param_permit
    params.require(:author).permit(:name,:active,:cover,:biography,:academics_list,:awards_list,:file)
  end

  def sort_column
    Author.fields.keys.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
