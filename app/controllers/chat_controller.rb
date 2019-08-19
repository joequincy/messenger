class ChatController < ApplicationController
  def index
    render locals: {
      rooms: Room.all
    }
  end
end
