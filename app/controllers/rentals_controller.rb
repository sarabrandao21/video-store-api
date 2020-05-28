class RentalsController < ApplicationController

  # need private controller filters to set video_id and set customer_id before running checkout/in methods
  before_action :set_customer, only: [:check_out, :check_in]
  before_action :set_video, only: [:check_out, :check_in]

  # check-out instance method










  

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
