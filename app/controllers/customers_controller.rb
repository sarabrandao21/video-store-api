class CustomersController < ApplicationController
    def index 
        customers = Customer.all.order(:name)
        render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count]),
                                         status: :ok
    end 
end

#test for creating video
#TODO we need a route to create video 
# describe "create" do 
#     it "can create a new video" do 
#         video_params = {
#             video: {
#                 title: "Blacksmith Of The Banished",
#                 overview: "The unexciting life of a boy will be permanently altered as a strange woman enters his life.",
#                 release_date: "1979-01-18",
#                 total_inventory: 10, 
#                 available_inventory: 9 
#             }
#         }
#         expect { post videos_path, params: video_params }.must_differ "Pet.count", 1 
#         must_respond_with :created
#     end 
# end 

#create method for video 
def create 
    video = Video.new(video_params)
    if video.save 
        render json: video.as_json(only: [:id]), status: :created
    else 
        #TODO 
    end 
end 

private 
def video_params
    return params.require(:video).permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
end 