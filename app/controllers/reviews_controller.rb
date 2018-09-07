class ReviewsController < ApplicationController
  layout "mylayout"
  def new
    @review = Review.new
    @reviewable_type = params[:type]
    @reviewable_id = params[:id]
  end

  def create
    @review = Review.new(param_permit)
    puts "New Review Data \n #{params}"
    @review.reviewable_id = params[:reviewable_id].to_i
    @review.reviewable_type = params[:reviewable_type]
    if @review.save
      flash[:notice] = "Review successfully created"
      redirect_to(:controller => params[:control], :action => "index")
    else
      flash[:error] = "Error in creating an review"
      render("new")
    end
  end

private
  def param_permit
    params.require(:review).permit(:name,:star_rate,:title,:desc)
  end
end
