class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews
  acts_as_likeable
end
