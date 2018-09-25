class ReviewsController < ApplicationController
  layout "application"
  before_action :authenticate_user!
  load_and_authorize_resource :review
  def new
    @review = Review.new
    @reviewable_type = params[:type]
    @reviewable_id = params[:id]
    puts "\n\n new review data from create failure #{@reviewable_id} and #{@reviewable_type} \n\n"
  end

  def create
    @review = Review.new(param_permit)
    puts "New Review Data \n #{params}"
    if @review.save
      @review.reviewable_id = params[:reviewable_id].to_i
      @review.reviewable_type = params[:reviewable_type]
      @review.save
      flash[:notice] = "Review successfully created"
      redirect_to(:controller => params[:control], :action => "show", :id => params[:reviewable_id])
    else
      flash[:error] = "Error in creating an review"
      redirect_to(:controller => "reviews", :action => "new", :type => params[:reviewable_type], :id => params[:reviewable_id].to_i)
    end
  end

private
  def param_permit
    params.require(:review).permit(:name,:star_rate,:title,:desc)
  end
end
