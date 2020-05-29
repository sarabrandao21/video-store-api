class RentalsController < ApplicationController

  # need private controller filters to set video_id and set customer_id before running checkout/in methods
  # before_action :set_customer, only: [:check_out, :check_in]
  # before_action :set_video, only: [:check_out, :check_in]
  def checkout
    video = Video.find_by(id: params[:video_id]) 
    customer = Customer.find_by(id: params[:customer_id])

  # check-out instance method

#   def checkin
#     new_video = Video.find_by(id: params[:video_id])
#     new_customer = Customer.find_by(id: params[:customer_id])
#     checkin = Rental.find_by(customer: new_customer, video: new_video)
# ​
#     if checkin.nil?
#       render json: {
#           errors: ['Not Found']
#         }, status: :not_found
#         return
#     else
#       render json: {
#         customer_id: checkin.customer_id,
#         video_id: checkin.video_id,
#         videos_checked_out_count: checkin.decrement_videos_checked_out_count,
#         available_inventory: checkin.increment_available_inventory
#     }, 
#       status: :ok
#       return 
#   end

  # check-in instance method

  def checkin
    # find the right rental instance in db to check in (video_id, customer_id)
    customer = Customer.find_by(id: params[:customer_id])
    video = Video.find_by(id: params[:video_id])
    rental = Rental.find_by(customer: customer, video: video)
    
    if rental
      # RENDER THE CORRECT JSON, update returned value and save
      render json: {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        videos_checked_out_count: rental.decrement_videos_checked_out_count,
        available_inventory: rental.increment_available_inventory
      }, status: :ok
      # rental.returned = true
      # rental.save
      return
    else
      # customer or video were nil
      render json: {
        errors: ['Not Found']
        }, status: :not_found
      return
    end
  end


  #     if rental.save
  #       # might need to change this based on smoke tests
  #       render json: {}, status: :ok
  #     else
  #       render json: { errors: rental.errors.messages }, status: :bad_request
  #     end
  #   else
  #     # BAD REQUEST - change based on smoke tests?
  #     render json: {
  #       errors: {
  #         rental: ["Customer #{@customer.id} has not checked out #{@video.title}"]
  #       }
  #     }, status: :not_found
  #     return
  #     end
  #   end
  # end

  private

  def set_customer
    @customer = Customer.find_by(id: params[:customer_id])

    if @customer.nil?
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

  def checkin

  end 


  def rental_params
    return params.permit(:customer_id, :video_id)
  end 

end
