class RentalsController < ApplicationController

  # need private controller filters to set video_id and set customer_id before running checkout/in methods
  before_action :set_customer, only: [:check_out, :check_in]
  before_action :set_video, only: [:check_out, :check_in]

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
        errors: { 
          customer_id: ["Error: couldn't find a customer with customer_id #{params[:customer_id]}"]
        }
      }, status: :not_found
    end
  end

  def set_video
    @video = Video.find_by(title: params[:title])

    if @video.nil?
      render json: { 
        errors: { 
          title: ["Error: couldn't find a video with title #{params[:title]}"]
        }
      }, status: :not_found
    end
  end

end
