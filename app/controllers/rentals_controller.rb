class RentalsController < ApplicationController

  # need private controller filters to set video_id and set customer_id before running checkout/in methods
  before_action :set_customer, only: [:check_out, :check_in]
  before_action :set_video, only: [:check_out, :check_in]

  # check-out instance method
  def index 
  end 



  #'customer_id', 'video_id', 'due_date', 'videos_checked_out_count', 'available_inventory'
  def check_out
   
  new_rent = Rental.new(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
  #videos_checked_out_count:, available_inventory:

    # increase the customer's videos_checked_out_count by one
    # decrease the video's available_inventory by one
    # create a due date. The rental's due date is the seven days from the current date.
  end 
  

  # check-in instance method












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
