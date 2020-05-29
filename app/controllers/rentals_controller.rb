class RentalsController < ApplicationController

  def checkout
    video = Video.find_by(id: params[:video_id]) 
    customer = Customer.find_by(id: params[:customer_id])

  # check-out instance method










  

  # check-in instance method

  def checkin
    # find the right rental instance in db to check in (video_id, customer_id)
    rental = Rental.find_by(params[:customer_id], params[:video_id])
    
    if rental
      # decrease customer's videos_checked_out_count by 1
      rental.customer.videos_checked_out_count -= 1
      # increase movie's available_inventory count by 1
      rental.video.available_inventory += 1
      # update rental instance in db/save => returned = true
      rental.returned = true

      if rental.save
        # might need to change this based on smoke tests
        render json: {}, status: :ok
      else
        render json: { errors: rental.errors.messages }, status: :bad_request
      end
    else
      # BAD REQUEST - change based on smoke tests?
      render json: {
        errors: {
          rental: ["Customer #{@customer.id} has not checked out #{@video.title}"]
        }
      }, status: :not_found
      return
      end
    end
  end

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
