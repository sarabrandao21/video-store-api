class Video < ApplicationRecord
    validates :title, presence: true 
    #:overview, :release_date, :total_inventory, :available_inventory
end
