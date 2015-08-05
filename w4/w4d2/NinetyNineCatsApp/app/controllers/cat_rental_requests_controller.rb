class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(rental_params)
    if @cat_rental_request.save!
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find_by_id(params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  private

  def rental_params
    params.require(:cat_rental_request).permit(:cat_id,:start_date,:end_date)
  end
end
