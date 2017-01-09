class Category < ActiveRecord::Base
  has_many :room_categories
  has_many :rooms, through: :room_categories
  validates :name, presence:true,length: {minimum:3,maximum:25}
  validates_uniqueness_of :name
end