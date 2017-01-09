class RoomCategory < ActiveRecord::Base
  belongs_to :room
  belongs_to :category
end
  