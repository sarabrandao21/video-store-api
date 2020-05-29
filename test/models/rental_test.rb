require "test_helper"

describe Rental do
  before do 
    @rental = rentals(:rental_1)
    @customer = customers(:shelley)
    @video = videos(:video_1)
  end 
  describe "validations" do 
    it "can not create rental without due_date" do 
      @rental.due_date = nil 
      expect(@rental.valid?).must_equal false 
      expect(@rental.errors.messages[:due_date]).must_equal ["can't be blank"]
    end 
  end 
  describe "relations" do 
    it "will have customer id" do 
      new_rental = Rental.new(customer_id: @customer.id, video_id: @video.id)
      new_rental.save
      expect(new_rental.customer_id).must_equal @customer.id
    end 
  end 
  describe "increment_videos_checked_out_count" do 
    it "can increment videos checked out" do 
      new_customer = Customer.create!(
        name: "Shelley Rocha",
        registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
        phone: "(322) 510-8695",
        videos_checked_out_count: 0
        )
      expect(new_customer.videos_checked_out_count).must_equal 0 
      new_rental = Rental.create!(customer_id: new_customer.id, video_id: @video.id, due_date: Date.today + 7)
      new_customer.reload
      @video.reload
      expect(new_customer.videos_checked_out_count).must_equal 1
    end 
  end 
  describe "decrement_available_inventory" do 
    it "can decrement_available_inventory" do 
      expect(@video.available_inventory).must_equal 8
      new_rental = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
      @customer.reload
      @video.reload
      expect(@video.available_inventory).must_equal 7
    end
  end 
  describe "decrement_videos_checked_out_count" do 
    it "can decrement_videos_checked_out_count" do 
      
    end 
  end 
  describe "increment_available_inventory" do 
    it "increment_available_inventory" do 
    end 
  end 
end
