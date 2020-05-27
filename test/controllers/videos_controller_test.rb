require "test_helper"

describe VideosController do
  INDEX_FIELDS = ["id", "title", "overview", "release_date", "available_inventory"].sort
  SHOW_FIELDS = ["title", "overview", "release_date", "available_inventory", "total_inventory"].sort

  describe "index" do
    it "must get index" do
      get videos_path
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "will return proper fields for a list of videos" do
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal INDEX_FIELDS
      end
    end

    it "returns empty array is no videos exist" do
      Video.destroy_all
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end

  describe "show" do

    it "will return a hash with the proper fields for an existing video" do
      video = videos(:video_1)
      get video_path(video.id)
      body = JSON.parse(response.body)
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal SHOW_FIELDS
    end

    it "will return a 404 request with json for a non-existing video" do
        get video_path(-1)

        must_respond_with :not_found
        body = JSON.parse(response.body)
        expect(body).must_be_instance_of Hash
        expect(body['ok']).must_equal false
        expect(body['message']).must_equal 'Video not found'
    end
  end

  describe "create" do
    it "must get create" do
      get videos_create_url
      must_respond_with :success
    end
  end

end
