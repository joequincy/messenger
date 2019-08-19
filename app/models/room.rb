class Room < ApplicationRecord
  has_many :messages
  has_many :users, through: :messages

  validates_presence_of :name
end
