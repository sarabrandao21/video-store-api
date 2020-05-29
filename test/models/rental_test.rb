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

  end 
  describe "decrement_available_inventory" do 
    
  end 
end
