class Subscriber < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def name
    user.name
  end
end
