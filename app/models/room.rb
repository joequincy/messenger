class Room < ApplicationRecord
  has_many :messages
  has_many :subscribers
  has_many :users, through: :subscribers

  validates_presence_of :name
end
