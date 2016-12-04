class Product < ActiveRecord::Base
  has_many :categories, through: :categorizations
  has_many :categorizations
  belongs_to :publisher
end
