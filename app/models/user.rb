class User < ApplicationRecord
  has_many :messages
  has_many :subscribers
  has_many :rooms, through: :subscribers

  validates_presence_of :name
end
