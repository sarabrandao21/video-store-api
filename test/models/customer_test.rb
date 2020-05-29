require "test_helper"

describe Customer do
  before do 
    @customer = customers(:shelley)
  end 
  describe "validations" do 
    
    it "can not create customer without name" do 
      @customer.name = nil 
      @customer.save
      expect(@customer.valid?).must_equal false 
      expect(@customer.errors.messages[:name]).must_equal ["can't be blank"]
    end 
    it "can not create customer without phone" do 
      @customer.phone = nil 
      @customer.save 
      expect(@customer.valid?).must_equal false 
      expect(@customer.errors.messages[:phone]).must_equal ["can't be blank"]
    end 
    it "can not create customer without registered_at" do 
      @customer.registered_at = nil 
      @customer.save 
      expect(@customer.valid?).must_equal false 
      expect(@customer.errors.messages[:registered_at]).must_equal ["can't be blank"]
    end 
    
  end 

  describe "Relations" do 
    it "can have multiple rentals" do 
      
    end 
    it "can have multiple videos through rentals" do 
    end 

  end 

end
