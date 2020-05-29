require "test_helper"

describe RentalsController do
  before do
    @customer = customers(:shelley)
    @video = videos(:video_1)
    @rental = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
    @rental_params = {
      customer_id: @customer.id,
      video_id: @video.id
    }
  end
  describe "checkout" do 
    
    it "can create a rental for valid input and responds with ok" do 
      available_before_rental = @video.available_inventory #int 1mu
      customer_rentals_before_count = @customer.rentals.count
      expect { post checkout_path, params: @rental_params }.must_differ "Rental.count", 1
      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'
      expect(@customer.rentals.count).must_equal (customer_rentals_before_count + 1)
      # expect(@video.available_inventory).must_equal (available_before_rental - 1)
      # expect(rental info here).must_equal @video.available_inventory
      # expect that the rental is added to the customer's rentals (increments video_checked_out_count)
      # expect that the rental is decreasing the video's available_inventory count
    end 
    it "returns a bad request when inventory is 0 before rental checkout" do 
      @video.available_inventory = 0 
      @video.save 
      expect { post checkout_path, params: @rental_params }.wont_change "Rental.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
    end 
    it "returns not_found when video is not found for rental" do
      rental_params = {
        customer_id: @customer.id,
        video_id: -1
      }
      expect { post checkout_path, params: rental_params }.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
    end
    it "returns not_found when customer is not found for rental" do
      rental_params = {
        customer_id: -3,
        video_id: @video.id
      }
      expect { post checkout_path, params: rental_params }.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
    end
  end 

  describe "checkin" do
   
    it "returns 200 ok status and correct json when checking in an existing valid rental" do
      expect { post checkin_path, params: @rental_params }.wont_differ "Rental.count"
      must_respond_with :ok
      #expect(response.header['Content-Type']).must_include 'json'
      # check the json keys/values
      # expect(response.body.keys.sort)
    end
    it "returns not found if the rental params are invalid" do
    end
  end
end