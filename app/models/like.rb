class Like < ApplicationRecord
  belongs_to :post 
  belongs_to :post class_name: "User"
end