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
  end 
end