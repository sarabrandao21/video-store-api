class CustomersController < ApplicationController
    def index 
        @customers = Customer.all.order(:name)
    end 
end
