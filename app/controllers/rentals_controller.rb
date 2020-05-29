class RentalsController < ApplicationController

  def checkout
    video = Video.find_by(id: params[:video_id]) 
    customer = Customer.find_by(id: params[:customer_id])
    if video.nil? || customer.nil?
      render json: {
        errors: ['Not Found']
       }, status: :not_found
      return
    end 
    if video.available_inventory <= 0 
      render json: { errors: video.errors.messages }, status: :bad_request
      return
    elsif video && customer
      new_rent = Rental.new(rental_params)
      new_rent.due_date = Date.today + 7

      if new_rent.save 
        render json: {
          customer_id: new_rent.customer_id,
          video_id: new_rent.video_id,
          due_date: new_rent.due_date,
          videos_checked_out_count: new_rent.customer.videos_checked_out_count,
          available_inventory: new_rent.video.available_inventory
        }, status: :ok
        return
      else
        render json: {
          errors: rental.errors.messages 
        }, status: :bad_request
        return 
      end 
    end 
  end 

  def rental_params
    return params.permit(:customer_id, :video_id)
  end 

end
