require "test_helper"

describe RentalsController do

  # TODO FILL IN THESE TESTS
  describe "set_customer" do
    it "correctly finds an existing valid customer" do
      customer = customers(:shelley)

      expect(self.set_customer).must_equal customer

    end

    it "returns json with an error message if the customer could not be found" do
    end
  end

  describe "set_video" do
    it "correctly finds and existing valid video" do
    end

    it "returns json with an error message if the video could not be found" do
    end
  end
end
