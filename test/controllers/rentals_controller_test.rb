require "test_helper"
require 'pry'
describe RentalsController do
  describe "checkout" do 
    before do
      @customer = customers(:shelley)
      @video = videos(:video_1)
      @rental = rentals(:rental_1)
      @rental_params = {
        customer_id: @customer.id,
        video_id: @video.id
      }
    end

    it "finds the correct customer_id and video_id for checking in an existing valid rental" do
      expect(@rental).wont_be_nil
      

      expect{ post checkin_path, params: @rental_params }.wont_change "Rental.count"
    end

    it "returns 200 ok status and json when checking in an existing valid rental" do

      expect { post checkin_path, params: @rental_params }.wont_differ "Rental.count"
      must_respond_with :ok
      # expect(response.header['Content-Type']).must_include 'json'
      # expect()
    end
    it "can create a rental for valid input and responds with ok" do 
      available_before_rental = @video.available_inventory #int 1mu
      customer_rentals_before_count = @customer.rentals.count
      expect { post checkout_path, params: @rental_params }.must_differ "Rental.count", 1
      must_respond_with :ok
      binding.pry
      puts "HERE IS THE CUSTOMER RENTALS COUNT: #{@customer.rentals.count}"
      puts "HERE IS THE VIDEO INVENTORY COUNT: #{@video.available_inventory}"
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

    it "increases the video's available count by 1 for a valid rental" do
    end

    # it "sets the rental's returned status to be true for a valid rental" do
    # end

    it "returns error message and 404 not_found for a rental with a customer that does not exist" do

    end

    it "returns error message and 404 not_found for a rental with a video that does not exist" do
    end


  end

  # TODO FILL IN THESE TESTS
  # describe "set_customer" do
  #   it "correctly finds an existing valid customer" do
  #     customer = customers(:shelley)

  #     expect(self.set_customer).must_equal customer

  #   end

  #   it "returns json with an error message if the customer could not be found" do
  #   end
  # end

  # describe "set_video" do
  #   it "correctly finds and existing valid video" do
  #   end

  #   it "returns json with an error message if the video could not be found" do
  #   end
  # end
end
  end 
end
