class VideosController < ApplicationController
  def index
    @videos = Video.all.order(:title)

    # render json: { ok: 'RENDERING JSON??'}, status: :ok
  end

  def show
  end

  def create
  end
end
