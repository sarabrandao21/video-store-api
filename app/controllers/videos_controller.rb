class VideosController < ApplicationController
  require 'pry'
  def index
    videos = Video.all.order(:title)

    render json: videos.as_json(only: [:id, :title, :release_date,
                                       :available_inventory]), status: :ok
  end

  def show
    video = Video.find_by(id: params[:id])

    if video.nil?
      render json: {
        errors: ['Not Found']
      }, status: :not_found
      return
    end

    render json: video.as_json(only: [:title, :overview, :release_date,
                                      :total_inventory, :available_inventory]), status: :ok
  end

  def create 
    video = Video.new(video_params)
    if video.save! 
      #only render the id because user does not need the other info
        render json: video.as_json(only: [:id]), status: :created
        return 
       
        # render json: { "video": { "id": video.id }}
    else 
        render json: { ok: false, errors: video.errors.messages }, status: :bad_request
        return 
    end 
  end 

  private 
  def video_params
    #TODO check if we need all the params as permit 
      return params.permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end 
end
