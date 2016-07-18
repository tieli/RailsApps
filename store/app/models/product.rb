class Product < ActiveRecord::Base
  has_many :categories, through: :categorizations
  has_many :categories
  belongs_to :publisher
end
